module dub.selections_lock.generate_selections_lock;

import std.algorithm : canFind, each, find, filter, map, sort, startsWith;
import std.array : array, assocArray, replace;
import std.conv : to;
import std.exception : enforce;
import std.file : copy, exists, getSize, isFile, mkdirRecurse, read, readText, rmdirRecurse, tempDir;
import std.format : format;
import std.json : parseJSON, JSONOptions, JSONType, JSONValue;
import std.path : baseName, buildNormalizedPath, relativePath;
import std.range : empty, join;
import std.string : assumeUTF, endsWith, startsWith, stripRight;
import std.stdio : File, toFile;
import std.typecons : Flag, tuple;

import integrity_hash : computeIntegrityHash;
import mvs : ModuleVersion, minimalVersionSelection;
import semver : SemVer, SemVerRange;

struct Config
{
    string bazelGeneratingTarget;
    string cachePath;
    string dubExecutable;
    enum string dubRegistryUrl = "https://code.dlang.org/packages";
    Flag!"SkipSSLVerification" skipSSLVerification;
    Flag!"Verbose" verbose;
}

__gshared Config _config;

void setConfig(string bazelGeneratingTarget, string cachePath, string dubExecutable,
    Flag!"SkipSSLVerification" skipSSLVerification, Flag!"Verbose" verbose)
{
    if (!bazelGeneratingTarget.empty)
        _config.bazelGeneratingTarget = bazelGeneratingTarget;
    if (!cachePath.empty)
        _config.cachePath = cachePath;
    if (!dubExecutable.empty)
        _config.dubExecutable = dubExecutable;
    _config.skipSSLVerification = skipSSLVerification;
    _config.verbose = verbose;
}

auto config()
{
    return _config;
}

struct Package
{
    string name;
    string version_;
    string integrity;
    string buildFileContent;
    string mainTargetName;
    Target[] targets;

    string archiveFile() const
    {
        return buildNormalizedPath(config.cachePath, "%s.zip".format(versionedName));
    }

    string unpackPath() const
    {
        return buildNormalizedPath(config.cachePath, versionedName);
    }

    string url() const
    {
        return format!"%s/%s/%s.zip"(config.dubRegistryUrl, name, version_);
    }

    string versionedName() const
    {
        return "%s-%s".format(name, version_);
    }
}

Package[] parseDubSelectionsJson(string content)
{
    auto json = content.parseJSON;
    enforce(json.type == JSONType.object, "Expected JSON object at root.");
    enforce(json["fileVersion"].integer == 1, "Unsupported fileVersion, expected 1.");

    return json["versions"]
        .object
        .byKeyValue
        .map!(item => Package(item.key, item.value.str))
        .array;
}

string generateDubSelectionsJson(string manifestFilePath)
{
    import std.process : execute;

    auto manifestFileName = manifestFilePath.baseName;
    auto packagePath = buildNormalizedPath(config.cachePath, "__dub_manifest_root__");
    if (packagePath.exists)
        packagePath.rmdirRecurse;
    packagePath.mkdirRecurse;
    scope (exit)
    {
        if (packagePath.exists)
            packagePath.rmdirRecurse;
    }

    auto packageManifestFilePath = buildNormalizedPath(packagePath, manifestFileName);
    manifestFilePath.copy(packageManifestFilePath);

    auto command = [
        config.dubExecutable,
        "upgrade",
        "--missing-only",
        "--root=%s".format(packagePath),
        "--cache=local",
        config.verbose ? "--verbose": "--quiet",
    ];

    auto result = execute(command);
    enforce(result.status == 0, "Failed to generate dub.selections.json from %s: %s".format(
            manifestFilePath, result.output));

    auto selectionsFilePath = buildNormalizedPath(packagePath, "dub.selections.json");
    enforce(selectionsFilePath.exists && selectionsFilePath.isFile,
        "Failed to generate dub.selections.json from %s.".format(manifestFilePath));
    return selectionsFilePath.readText;
}

Package[] readDubDependencies(string filePath)
{
    auto fileName = filePath.baseName;
    if (fileName == "dub.selections.json")
        return filePath.readText.parseDubSelectionsJson;
    if (fileName.endsWith(".json"))
    {
        auto content = filePath.readText;
        auto json = content.parseJSON;
        if (json.type == JSONType.object &&
            "fileVersion" in json.object &&
            "versions" in json.object)
            return content.parseDubSelectionsJson;
        return filePath.generateDubSelectionsJson.parseDubSelectionsJson;
    }
    if (fileName == "dub.sdl")
        return filePath.generateDubSelectionsJson.parseDubSelectionsJson;

    enforce(false, "Unsupported input file %s. Expected JSON selections, dub.json, or dub.sdl.".format(
            filePath));
    return [];
}

Package[] resolveDubDependencies(Package[] packages)
{
    enum rootVersion = "0.0.0";
    enum rootPrefix = "__rules_d_dub_lock_root_";
    SemVerRange[string] rootConstraints;
    SemVer[][string] availableVersions;
    SemVerRange[string][ModuleVersion] dependencies;
    Package[ModuleVersion] packageByVersion;

    foreach (i, package_; packages)
    {
        auto semVer = SemVer(package_.version_);
        enforce(semVer.isValid, "Invalid semantic version '%s' for package %s.".format(
                package_.version_, package_.name));
        auto rootName = rootPrefix ~ i.to!string;
        rootConstraints[rootName] = SemVerRange(">=" ~ rootVersion);
        availableVersions[rootName] = [SemVer(rootVersion)];
        dependencies[ModuleVersion(rootName, SemVer(rootVersion))] = [
            package_.name: SemVerRange(">=" ~ package_.version_),
        ];
        availableVersions[package_.name] ~= semVer;
        packageByVersion[ModuleVersion(package_.name, semVer)] = package_;
    }

    auto selectedVersions = minimalVersionSelection(rootConstraints, availableVersions, dependencies);
    return selectedVersions.byKeyValue
        .filter!(item => !item.key.startsWith(rootPrefix))
        .array
        .sort!((a, b) => a.key < b.key)
        .map!(item => packageByVersion[ModuleVersion(item.key, item.value)])
        .array;
}

void download(Package package_)
{
    import curl_downloader : CurlDownloader;

    auto downloader = CurlDownloader(config.skipSSLVerification);
    downloader.downloadToFile(package_.url, package_.archiveFile);
}

string computePackageIntegrity(Package package_)
{
    if (!package_.archiveFile.exists || package_.archiveFile.getSize == 0)
        package_.download;
    return computeIntegrityHash!256(package_.archiveFile);
}

void unpack(Package package_)
{
    import std.zip : ZipArchive;

    enforce(package_.archiveFile.exists, "Archive file %s does not exist.".format(
            package_.archiveFile));
    auto zip = new ZipArchive(package_.archiveFile.read);
    scope (failure)
    {
        package_.unpackPath.rmdirRecurse;
    }

    // create directories first
    foreach (name, am; zip.directory)
    {
        enforce(name.startsWith(package_.versionedName ~ "/"),
            "Unexpected entry %s in archive.".format(name));
        if (!name.endsWith("/"))
            continue;
        buildNormalizedPath(package_.unpackPath, "..", name).mkdirRecurse;
    }
    // then expand files
    foreach (name, am; zip.directory)
    {
        if (name.endsWith("/"))
            continue;
        zip.expand(am);
        am.expandedData.toFile(buildNormalizedPath(package_.unpackPath, "..", name));
    }
}

enum TargetType
{
    autodetect,
    none,
    executable,
    library,
    sourceLibrary,
    dynamicLibrary,
    staticLibrary,
    object
}

struct Target
{
    string targetName;
    TargetType targetType;
    string targetPath;
    string mainSourceFile;
    string[] dflags;
    string[] lflags;
    string[] libs;
    string[] sourceFiles;
    string[] injectSourceFiles;
    string[] versions;
    string[] importPaths;
    string[] stringImportPaths;
    string[] stringSrcs;
    string[string] environments;
    string[string] buildEnvironments;
    string[string] runEnvironments;
    string[] dependencies;
}

string[] relativePaths(JSONValue paths, string packagePath)
{
    return paths
        .array
        .map!(p => p.str.relativePath(packagePath).stripRight("/"))
        .filter!(p => !p.startsWith("../"))
        .array;
}

Target parseTarget(JSONValue json, string packagePath)
{
    Target target;
    target.dependencies = json["dependencies"].array.map!(v => v.str).array;
    json = json["buildSettings"].object;
    target.targetName = json["targetName"].str;
    enforce([JSONType.integer, JSONType.string].canFind(json["targetType"].type), "Invalid targetType JSON type.");
    if (json["targetType"].type == JSONType.integer)
        target.targetType = json["targetType"].integer.to!TargetType;
    else if (json["targetType"].type == JSONType.string)
        target.targetType = json["targetType"].str.to!TargetType;
    target.targetPath = json["targetPath"].str;
    target.mainSourceFile = json["mainSourceFile"].str;
    target.dflags = json["dflags"].array.map!(v => v.str).array;
    target.lflags = json["lflags"].array.map!(v => v.str).array;
    target.libs = json["libs"].array.map!(v => v.str).array;
    target.sourceFiles = json["sourceFiles"].relativePaths(packagePath);
    target.injectSourceFiles = json["injectSourceFiles"].relativePaths(packagePath);
    target.versions = json["versions"].array.map!(v => v.str).array;
    target.importPaths = json["importPaths"].relativePaths(packagePath);
    target.stringImportPaths = json["stringImportPaths"].relativePaths(packagePath);
    target.stringSrcs = json["stringImportFiles"].relativePaths(packagePath);
    target.environments = json["environments"].object.byKeyValue
        .map!(env => tuple(env.key, env.value.str)).assocArray;
    target.buildEnvironments = json["buildEnvironments"].object.byKeyValue
        .map!(env => tuple(env.key, env.value.str)).assocArray;
    target.runEnvironments = json["runEnvironments"].object.byKeyValue
        .map!(env => tuple(env.key, env.value.str)).assocArray;
    return target;
}

Target[] describePackage(Package package_, out string mainTargetName)
{
    import std.file : getcwd;
    import std.process : Config, execute;

    if (!package_.archiveFile.exists)
        package_.download;

    if (!package_.unpackPath.exists)
        package_.unpack;

    // return no targets if this is a Bazel package already
    if (package_.unpackPath.buildNormalizedPath("WORKSPACE").exists ||
        package_.unpackPath.buildNormalizedPath("MODULE.bazel").exists)
        return [];

    auto result = execute([
        config.dubExecutable,
        "describe",
        "--root=%s".format(package_.unpackPath),
    ]);
    enforce(result.status == 0, "Failed to describe package %s: %s".format(
            package_.versionedName, result.output));

    auto dub_description = result.output.parseJSON;
    if (config.verbose)
    {
        import std.stdio : writeln;

        writeln("Dub description for package ", package_.versionedName, ":\n",
            dub_description.toPrettyString(JSONOptions.doNotEscapeSlashes));
    }
    auto rootPackage = dub_description["packages"].array.find!(p => p["name"].str == package_.name);
    enforce(!rootPackage.empty, "Package %s not found in dub description.".format(
            package_.versionedName));
    mainTargetName = rootPackage[0]["targetName"].str;
    return dub_description["targets"].array
        .filter!(t => t["packages"].array.canFind(dub_description["rootPackage"]))
        .map!(t => parseTarget(t, package_.unpackPath))
        .array;
}

void expandDependencyTargetNames(ref Package package_, string[string] targetNameByPackage)
{
    foreach (ref target; package_.targets)
    {
        foreach (ref dep; target.dependencies)
        {
            auto targetName = dep in targetNameByPackage;
            if (targetName is null || *targetName == dep)
                continue;
            dep ~= ":" ~ *targetName;
        }
    }
}

string headerDefinition(bool hasBinary, bool hasLibrary)
{
    if (hasBinary && hasLibrary)
        return `load("@rules_d//d:defs.bzl", "d_binary", "d_library")`;
    else if (hasBinary)
        return `load("@rules_d//d:defs.bzl", "d_binary")`;
    else if (hasLibrary)
        return `load("@rules_d//d:defs.bzl", "d_library")`;
    return "";
}

string targetDefinition(Target target)
{
    string[] result;
    switch (target.targetType)
    {
    case TargetType.library:
    case TargetType.sourceLibrary:
    case TargetType.dynamicLibrary:
    case TargetType.staticLibrary:
        result ~= "d_library(";
        break;
    case TargetType.executable:
        result ~= "d_binary(";
        break;
    default:
        enforce(false, "Unsupported target type %s.".format(target.targetType));
        return "";
    }
    result ~= "    name = \"%s\",".format(target.targetName);
    if (!target.sourceFiles.empty)
        result ~= "    srcs = [%s],".format(target.sourceFiles
                .map!(s => "\"" ~ s ~ "\"").join(", "));
    if (!target.importPaths.empty)
        result ~= "    imports = [%s],".format(
            target.importPaths
                .map!(s => "\"" ~ s ~ "\"").join(", "));
    if (target.targetType == TargetType.sourceLibrary)
        result ~= "    source_only = True,";
    result ~= "    visibility = [\"//visibility:public\"],";
    if (!target.dependencies.empty)
        result ~= "    deps = [%s],".format(
            target.dependencies
                .map!(d => "\"@%DUB_REPOSITORY_NAME%//" ~ d ~ "\"").join(", "));
    result ~= ")\n";
    return result.join("\n");
}

string computeBuildFile(Package package_)
{
    bool hasBinary = package_.targets.canFind!(t => t.targetType == TargetType.executable);
    bool hasLibrary = package_.targets
        .canFind!(t => [
                TargetType.library, TargetType.sourceLibrary,
                TargetType.dynamicLibrary, TargetType.staticLibrary
            ].canFind(t.targetType));

    if (!hasBinary && !hasLibrary)
        return "";

    auto buildFileContent = headerDefinition(hasBinary, hasLibrary) ~ "\n\n" ~
        package_.targets
        .map!(t => targetDefinition(t))
        .join("\n");
    if (config.verbose)
    {
        import std.stdio : writeln;

        writeln("Generated BUILD file content for package ", package_.versionedName, ":\n", buildFileContent);
    }
    return buildFileContent;
}

void writeDubSelectionsLockJson(Package[] packages, string filePath)
{
    JSONValue outputJson;
    if (!config.bazelGeneratingTarget.empty)
        outputJson["_comment"] =
            format!"This file is auto-generated with `bazel run %s`. Do not edit."(
                config.bazelGeneratingTarget);
    outputJson["fileVersion"] = 1;
    outputJson["packages"] = packages.map!(p => tuple(p.name, (
            (p.buildFileContent.empty ?
            [] : [tuple("buildFileContent", p.buildFileContent)]) ~
            [
                tuple("integrity", p.integrity),
                tuple("url", p.url),
                tuple("version", p.version_),
            ]).assocArray)).assocArray;
    (outputJson
            .toPrettyString(JSONOptions.doNotEscapeSlashes)
            .replace("    ", "  ") ~ "\n")
        .toFile(filePath);
}

int main(string[] args)
{
    import std.getopt : defaultGetoptPrinter, getopt;
    import std.stdio : writefln, writeln;
    import std.process : environment;

    string bazelGeneratingTarget;
    string cachePath;
    string dub;
    string[] inputFilePaths;
    string outputFilePath;
    bool skipSSLVerification;
    bool verbose;

    auto parseArgs = args.getopt(
        "bazel_generating_target|b", "Document the bazel generating target.", &bazelGeneratingTarget,
        "cache_path|c", "Path to dub cache.", &cachePath,
        "dub|d", "Path to dub executable.", &dub,
        "input|i", "Input file path. May be repeated. One of dub.json, dub.sdl or, dub.selections.json.", &inputFilePaths,
        "output|o", "Output dub.selections.lock.json file path.", &outputFilePath,
        "skip_ssl_verification|s", "Skip SSL verification when downloading packages.", &skipSSLVerification,
        "verbose|v", "Enable verbose output.", &verbose,
    );

    if (parseArgs.helpWanted)
    {
        defaultGetoptPrinter(
            "Generates a dub.selections.lock.json file from one or more dub.json, dub.sdl or, dub.selections.json inputs.",
            parseArgs.options);
        return 0;
    }
    if (inputFilePaths.empty)
    {
        writeln("At least one input file path must be specified.");
        return 1;
    }
    foreach (inputFilePath; inputFilePaths)
    {
        if (!inputFilePath.exists || !inputFilePath.isFile)
        {
            writefln("Input file path %s does not exist or is not a file.", inputFilePath);
            return 1;
        }
    }
    if (outputFilePath.exists && !outputFilePath.isFile)
    {
        writefln("Output file %s is not a file.", outputFilePath);
        return 1;
    }
    if (cachePath.empty)
    {
        cachePath = buildNormalizedPath(tempDir, "__dub_selection_cache__");
        cachePath.mkdirRecurse;
    }
    if (dub.empty)
        dub = environment.get("DUB");
    enforce(!dub.empty, "DUB executable path must be specified via --dub option or DUB environment variable.");

    setConfig(bazelGeneratingTarget, cachePath, dub, skipSSLVerification.to!(
            Flag!"SkipSSLVerification"),
        verbose.to!(Flag!"Verbose"));

    auto packages = inputFilePaths
        .map!(inputFilePath => readDubDependencies(inputFilePath))
        .join
        .array
        .resolveDubDependencies;
    packages.each!((ref p) => p.integrity = computePackageIntegrity(p));
    packages.each!((ref p) => p.targets = describePackage(p, p.mainTargetName));
    auto targetNameByPackage = packages.map!(p => tuple(p.name, p.mainTargetName)).assocArray;
    packages.each!((ref p) => p.expandDependencyTargetNames(targetNameByPackage));
    packages.each!((ref p) => p.buildFileContent = computeBuildFile(p));

    writeDubSelectionsLockJson(packages, outputFilePath);
    return 0;
}
