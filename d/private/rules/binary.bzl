"""D test rule for compiling binaries."""

load("//d/private/rules:common.bzl", "TARGET_TYPE", "compilation_action", "runnable_attrs")

def _d_binary_impl(ctx):
    """Implementation of d_binary rule."""
    return compilation_action(ctx, target_type = TARGET_TYPE.BINARY)

d_binary = rule(
    implementation = _d_binary_impl,
    attrs = runnable_attrs,
    toolchains = ["//d:toolchain_type"],
    executable = True,
)
