"""Rule for compiling D libraries."""

load("//d/private:providers.bzl", "DInfo")
load("//d/private/rules:common.bzl", "TARGET_TYPE", "compilation_action", "library_attrs")

def _d_library_impl(ctx):
    """Implementation of d_library rule."""
    return compilation_action(ctx, target_type = TARGET_TYPE.LIBRARY)

d_library = rule(
    implementation = _d_library_impl,
    attrs = library_attrs,
    toolchains = ["//d:toolchain_type"],
    provides = [DInfo],
)
