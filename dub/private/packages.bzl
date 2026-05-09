"""Dub package registration."""

def register_package(repository_ctx, package):
    """Registers a dub package as an external repository.

    Args:
        repository_ctx: The repository context.
        package: A dictionary with the package information from the dub.selections.lock file.
    """

    repository_ctx.download_and_extract(
        url = package["url"],
        integrity = package["integrity"],
        stripPrefix = package.get("strip_prefix", "{}-{}".format(package["name"], package["version"])),
        output = package["name"],
    )
    if "buildFileContent" in package:
        repository_ctx.file(package["name"] + "/BUILD.bazel", package["buildFileContent"].replace("%DUB_REPOSITORY_NAME%", repository_ctx.original_name), executable = False)
