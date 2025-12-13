"""Rule for compiling D libraries."""

load("//d/private:providers.bzl", "DInfo")
load("//d/private/rules:compile.bzl", "TARGET_TYPE", "compilation_action", "library_attrs")

def _d_library_impl(ctx):
    """Implementation of d_library rule."""
    d_info = compilation_action(ctx, target_type = TARGET_TYPE.LIBRARY)
    return [
        d_info,
        DefaultInfo(files = depset([d_info.compilation_output])),
    ]

d_library = rule(
    implementation = _d_library_impl,
    attrs = library_attrs,
    toolchains = ["//d:toolchain_type"],
    provides = [DInfo],
)
