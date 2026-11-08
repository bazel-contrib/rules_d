"""Repository rule for the DUB module extension."""

load("//dub/private:packages.bzl", "register_package")

def _dub_repository_impl(repository_ctx):
    """Creates a dub package repository."""
    dub_selections_lock = json.decode(repository_ctx.read(repository_ctx.attr.dub_selections_lock))
    for package, package_info in dub_selections_lock.get("packages", {}).items():
        package_info["name"] = package
        repository_ctx.report_progress("Registering dub package {}({})".format(package, package_info.get("version")))
        register_package(repository_ctx, package_info)

dub_repository = repository_rule(
    implementation = _dub_repository_impl,
    attrs = {
        "dub_selections_lock": attr.label(mandatory = True, allow_single_file = True),
    },
)
