import std.algorithm : chunkBy, countUntil, each, filter, map, sort, splitter, uniq;
import std.array : array, appender, assocArray, join;
import std.conv : to;
import std.datetime.date : DateTime;
import std.datetime.systime : Clock, SysTime;
import std.file : exists, getSize, isDir, remove, write;
import std.format : format;
import std.json : JSONValue, parseJSON;
import std.path : baseName, buildPath;
import std.range : empty, take;
import std.stdio : File, writefln, writeln;
import std.string : assumeUTF;
import std.regex : escaper, matchAll, matchFirst, regex;
import std.typecons : Nullable, nullable, tuple;

import curl_downloader : CurlDownloader, CurlException;
import integrity_hash : computeIntegrityHash;

string GITHUB_API_URL = "https://api.github.com/repos";
string GITHUB_LDC_REPO = "ldc-developers/ldc";

string[] ARCHIVE_TYPES = [".tar.xz", ".zip"]; // in order of the preference
string[] OSES = ["linux", "osx", "windows"];
string[] CPUS = ["aarch64", "amd64", "arm64", "x86_64"];
string DMD_REPO_URL = "https://downloads.dlang.org";
string DMD_CHANGELOG_URL = "https://dlang.org/changelog/index.html";

struct CompilerReleaseInfo
{
    string compiler; // "dmd" | "ldc"
    string version_; // "2.104.0", "1.39.0", ...
    string os; // "linux" | "macos" | "windows"
    string cpu; // "x86_64" | "aarch64" ...
    string archive; // ".tar.xz" | ".zip"
    string url;
    string fileName;
    string integrity; // computed integrity metadata
}

string canonicalCpu(string cpu)
{
    if (cpu == "amd64")
        return "x86_64";
    else if (cpu == "arm64")
        return "aarch64";
    else
        return cpu;
}

string canonicalOs(string os)
{
    if (os == "osx")
        return "macos";
    else
        return os;
}

auto semverFromString(string version_)
{
    return version_.splitter(".").take(3).map!(part => part.to!int).array;
}

auto removeDuplicates(CompilerReleaseInfo[] releases)
{
    // remove release duplicates that differ on archive type only
    return releases
        .sort!((a, b) =>
                tuple(a.compiler, semverFromString(a.version_), a.os, a.cpu, ARCHIVE_TYPES.countUntil(
                    a.archive)) <
                tuple(b.compiler, semverFromString(b.version_), b.os, b.cpu, ARCHIVE_TYPES.countUntil(
                    b.archive)))
        .uniq!((a, b) =>
                tuple(a.compiler, semverFromString(a.version_), a.os, a.cpu) ==
                tuple(b.compiler, semverFromString(b.version_), b.os, b.cpu));
}

Nullable!CompilerReleaseInfo getDmdCompilerReleaseInfo(string url)
{
    // match strings like dmd.2.095.1.linux.tar.xz
    auto dmdReleaseRe = regex(format!"dmd[.](.*)[.](%s)(%s)"(
            OSES.join("|"), ARCHIVE_TYPES.map!escaper.join("|")));

    auto match = url.baseName.matchFirst(dmdReleaseRe);
    if (!match || !match.post.empty || !match.pre.empty)
    {
        return Nullable!CompilerReleaseInfo.init;
    }
    return CompilerReleaseInfo(
        "dmd",
        match[1],
        canonicalOs(match[2]),
        canonicalCpu("x86_64"),
        match[3],
        DMD_REPO_URL ~ url,
        url.baseName,
        "",
    ).nullable;
}

auto getDmdReleases(int lookbackYears)
{
    int cutoffYear = Clock.currTime.year - lookbackYears;
    writefln("Getting DMD compiler releases since %s...", cutoffYear);

    auto downloader = CurlDownloader();
    string response = downloader.get(DMD_CHANGELOG_URL).assumeUTF;
    auto compilerVersions = response
        .matchAll("<li><a id=\"(.*)\" href=.*[(](\\w{3} \\d{1,2}, \\d{4})[)]</span></li>")
        .filter!(match => cutoffYear <= match[2][$ - 4 .. $].to!int)
        .map!(match => match[1])
        .array
        .sort
        .uniq;
    auto compilerReleases = appender!(CompilerReleaseInfo[])();
    foreach (version_; compilerVersions)
    {
        try
        {
            writefln("Found dmd-%s", version_);
            response = downloader.get(DMD_REPO_URL ~ "/releases/2.x/" ~ version_ ~ "/").assumeUTF;
        }
        catch (CurlException e)
        {
            writefln("DMD version %s not found, skipping...", version_);
            continue;
        }
        response
            .matchAll("<li><a href=\"(.*)\">.*</a></li>")
            .map!(match => getDmdCompilerReleaseInfo(match[1].to!string))
            .filter!(info => !info.isNull)
            .each!(info => compilerReleases.put(info.get));
    }
    return removeDuplicates(compilerReleases.data);
}

Nullable!CompilerReleaseInfo getLdcCompilerReleaseInfo(JSONValue asset)
{
    // match strings like ldc2-1.39.0-linux-amd64.tar.xz
    auto ldcReleaseRe = regex(format!"ldc2-(.*)-(%s)-(%s)(%s)"(
            OSES.join("|"), CPUS.join("|"), ARCHIVE_TYPES.map!escaper.join("|")));

    auto match = asset["name"].str.matchFirst(ldcReleaseRe);
    if (!match || !match.post.empty || !match.pre.empty)
    {
        return Nullable!CompilerReleaseInfo.init;
    }
    return CompilerReleaseInfo(
        "ldc",
        match[1],
        canonicalOs(match[2]),
        canonicalCpu(match[3]),
        match[4],
        asset["browser_download_url"].str,
        asset["name"].str,
        "",
    ).nullable;
}

auto getLdcReleases(int lookbackYears, string githubToken)
{
    int cutoffYear = Clock.currTime.year - lookbackYears;
    writefln("Getting LDC compiler releases since %s...", cutoffYear);

    auto downloader = CurlDownloader();
    string response = downloader
        .get(format!"%s/%s/releases?per_page=1000"(GITHUB_API_URL, GITHUB_LDC_REPO), githubToken)
        .assumeUTF;

    auto releases = parseJSON(response);
    auto compilerReleases = appender!(CompilerReleaseInfo[])();
    foreach (release; releases.array)
    {
        if (release["prerelease"].boolean || release["published_at"].str[0 .. 4].to!int < cutoffYear)
        {
            continue;
        }
        compilerReleases.put(
            release["assets"].array
                .map!(asset => getLdcCompilerReleaseInfo(asset))
                .filter!(info => !info.isNull)
                .map!(info => info.get)
        );
    }

    return removeDuplicates(compilerReleases.data);
}

void downloadRelease(CompilerReleaseInfo release, string cacheDir)
{
    auto assetFile = buildPath(cacheDir, release.fileName);
    if (assetFile.exists && assetFile.getSize > 0)
    {
        writefln("%s is already downloaded.", release.fileName);
        return;
    }
    writefln("Downloading from %s...", release.url);
    try
    {
        auto downloader = CurlDownloader();
        downloader.downloadToFile(release.url, assetFile);
    }
    catch (CurlException e)
    {
        writefln("Failed to download %s: %s", release.url, e.msg);
        if (assetFile.exists)
            assetFile.remove;
    }

    writefln("Downloaded %s to %s.", release.fileName, assetFile);
}

string platformId(string os, string cpu)
{
    if (os == "linux")
        return format!"%s-unknown-linux-gnu"(cpu);
    else if (os == "macos")
        return format!"%s-apple-darwin"(cpu);
    else if (os == "windows")
        return format!"%s-pc-windows-msvc"(cpu);
    else
        return "unknown";
}

void generateVersionsBzl(CompilerReleaseInfo[] releases, string sdkVersionsBzlFile)
{
    import std.json : JSONValue;

    string header = `"""Mirror of D compiler release information.

This file is generated with:
bazel run -- //tools:generate_compiler_versions_bzl -c ~/.cache/d_releases --github-token <GITHUB_TOKEN> \
    -o ${PWD}/d/private/sdk/versions.bzl
"""

SDK_VERSIONS = `;

    // format as ordered json
    string result = "{\n%-(    %s,\n%),\n}\n".format(
        releases
            .sort!((a, b) =>
                tuple(a.compiler, semverFromString(a.version_), a.os, a.cpu) <
                tuple(b.compiler, semverFromString(b.version_), b.os, b.cpu))
            .chunkBy!(a => tuple!("compiler", "version_")(a.compiler, a.version_))
            .map!(info => "\"%s-%s\": {\n%-(        %s,\n%),\n    }".format(
                info[0].compiler, info[0].version_,
                info[1]
                .map!(info => "\"%s\": {\n            \"url\": \"%s\",\n            \"integrity\": \"%s\",\n        }"
                .format(platformId(info.os, info.cpu), info.url, info.integrity)))));

    write(sdkVersionsBzlFile, header ~ result);
}

void main(string[] args)
{
    import std.exception : enforce;
    import std.getopt : defaultGetoptPrinter, getopt;

    string cacheDir;
    bool skipDmd = false;
    bool skipLdc = false;
    bool noRefresh = false;
    string githubToken;
    string sdkVersionsBzlFile;
    int lookbackYears = 5;
    auto parseResult = args.getopt(
        "cache|c", "Cache directory", &cacheDir,
        "skip-dmd", "Skip DMD compilers", &skipDmd,
        "skip-ldc", "Skip LDC compilers", &skipLdc,
        "no-refresh|n", "Don't check upstream. Use local cache-only", &noRefresh,
        "github-token", "GitHub token", &githubToken,
        "sdk_versions_bzl_file|o", "Output compiler versions .bzl file", &sdkVersionsBzlFile,
        "lookback-years", "How many years back to look for releases (default: 5)", &lookbackYears,
    );
    if (parseResult.helpWanted)
    {
        defaultGetoptPrinter("Utility for checking compiler releases", parseResult.options);
        return;
    }
    enforce(cacheDir.exists && cacheDir.isDir,
        format!"Error: cache parameter '%s' is not a directory"(cacheDir));
    enforce(skipLdc || !githubToken.empty, "Error: No GitHub token specified");

    auto compilerReleases = appender!(CompilerReleaseInfo[])();
    if (!skipDmd)
        compilerReleases.put(getDmdReleases(lookbackYears));
    if (!skipLdc)
        compilerReleases.put(getLdcReleases(lookbackYears, githubToken));

    writeln("Downloading compiler releases");
    compilerReleases.data.each!(r => r.downloadRelease(cacheDir));
    writeln("Computing integrity metadata");
    compilerReleases.data
        .each!((ref r) => r.integrity = buildPath(cacheDir, r.fileName).computeIntegrityHash!384);

    if (!sdkVersionsBzlFile.empty)
        generateVersionsBzl(
            compilerReleases.data, sdkVersionsBzlFile);
}
