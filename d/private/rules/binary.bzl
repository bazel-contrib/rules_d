"""D test rule for compiling binaries."""

load("@rules_cc//cc:find_cc_toolchain.bzl", "use_cc_toolchain")
load("//d/private/rules:compile.bzl", "TARGET_TYPE", "compilation_action", "runnable_attrs")
load("//d/private/rules:link.bzl", "link_action")

def _d_binary_impl(ctx):
    """Implementation of d_binary rule."""
    d_info = compilation_action(ctx, target_type = TARGET_TYPE.BINARY)
    return link_action(ctx, d_info)

d_binary = rule(
    implementation = _d_binary_impl,
    attrs = runnable_attrs,
    toolchains = ["//d:toolchain_type"] + use_cc_toolchain(),
    fragments = ["cpp"],
    executable = True,
)
