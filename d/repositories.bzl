"""Repository helpers for the D toolchain module extension."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//d/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")
load("//d/private/sdk:versions.bzl", "SDK_VERSIONS")

def http_archive(name, **kwargs):
    maybe(_http_archive, name = name, **kwargs)

def dub_dependency(name, package, version, integrity = "", sha256 = "", strip_prefix = ""):
    """Fetches a DUB package as an external repository.

    Args:
        name: Repository name for the DUB package.
        package: DUB package name.
        version: DUB package version.
        integrity: Optional SRI integrity for the DUB package archive.
        sha256: Optional sha256 for the DUB package archive.
        strip_prefix: Optional archive strip prefix. Defaults to `{package}-{version}`.
    """
    kwargs = {
        "strip_prefix": strip_prefix or "%s-%s" % (package, version),
        "urls": [
            "https://code.dlang.org/packages/%s/%s.zip" % (package, version),
        ],
    }
    if integrity:
        kwargs["integrity"] = integrity
    if sha256:
        kwargs["sha256"] = sha256
    http_archive(name = name, **kwargs)

########
# Remaining content of the file is only used to support toolchains.
########
_DOC = "Fetch external tools needed for d toolchain"
_ATTRS = {
    "d_version": attr.string(mandatory = True, values = SDK_VERSIONS.keys()),
    "platform": attr.string(mandatory = True, values = PLATFORMS.keys()),
}

def _archive_prefixes(url):
    filename = url.rsplit("/", 1)[-1]
    stem = ""
    for ext in [".tar.xz", ".zip"]:
        if filename.endswith(ext):
            stem = filename[:-len(ext)]
            break
    if not stem:
        fail("Unknown archive name format: %s" % filename)
    return ["%s/dmd2" % stem, "%s/ldc" % stem, stem, "dmd2", "ldc"]

def _d_repo_impl(repository_ctx):
    d_version = repository_ctx.attr.d_version
    platform = repository_ctx.attr.platform

    if d_version not in SDK_VERSIONS:
        fail("Unknown d_version: %s" % d_version)
    if platform not in SDK_VERSIONS[d_version]:
        fail("Unsupported platform: %s for %s" % (platform, d_version))
    sdk = SDK_VERSIONS[d_version][platform]
    sdk_path = "sdk-out"
    repository_ctx.download_and_extract(
        url = sdk["url"],
        integrity = sdk["integrity"],
        output = sdk_path,
    )
    prefix_found = False
    for prefix in _archive_prefixes(sdk["url"]):
        prefix_path = repository_ctx.path("%s/%s" % (sdk_path, prefix))
        if prefix_path.is_dir:
            for entry in prefix_path.readdir():
                repository_ctx.symlink(entry, entry.basename)
            prefix_found = True
            break
    if not prefix_found:
        fail("Unexpected archive structure: %s" % sdk["url"])

    build_bazel_template = "@rules_d//d/private/sdk:BUILD.%s.bazel" % d_version[0:3]

    # Base BUILD file for this repository
    repository_ctx.template("BUILD.bazel", Label(build_bazel_template))

d_repositories = repository_rule(
    _d_repo_impl,
    doc = _DOC,
    attrs = _ATTRS,
)

def d_register_toolchains(name, **kwargs):
    """Creates SDK repositories and toolchain targets for the module extension.

    Register the generated toolchains in MODULE.bazel.

    Args:
        name: base name for all created repositories
        **kwargs: passed to each d_repositories call
    """
    for platform in PLATFORMS.keys():
        d_version = kwargs.get("d_version")
        if not d_version or d_version not in SDK_VERSIONS or platform not in SDK_VERSIONS[d_version]:
            continue
        d_repositories(name = name + "_" + platform, platform = platform, **kwargs)

    toolchains_repo(
        name = name + "_toolchains",
        user_repository_name = name,
    )

def _get_platform_id(os):
    """Get the platform id for the given os repository_os information."""
    if os.name == "linux":
        if os.arch in ["amd64", "x86_64"]:
            return "x86_64-unknown-linux-gnu"
        elif os.arch in ["aarch64", "arm64"]:
            return "aarch64-unknown-linux-gnu"
    elif os.name in ["darwin", "mac os x", "macos", "osx"]:
        if os.arch in ["amd64", "x86_64"]:
            return "x86_64-apple-darwin"
        elif os.arch in ["aarch64", "arm64"]:
            return "aarch64-apple-darwin"
    elif "windows" in os.name:
        if os.arch in ["amd64", "x86_64"]:
            return "x86_64-pc-windows-msvc"
    fail("Unsupported OS/arch combination: %s/%s" % (os.name, os.arch))

def select_compiler_by_os(versions, os):
    """Select the most appropriate compiler version for the given OS.

    Args:
        versions: list of compiler versions
        os: repository_os information

    Returns:
        selected compiler version
    """
    platform_id = _get_platform_id(os)
    for version in versions:
        if platform_id in SDK_VERSIONS.get(version, {}):
            return version
    fail("No suitable d compiler found for OS %s among versions: %s." % (os, ", ".join(versions)))
