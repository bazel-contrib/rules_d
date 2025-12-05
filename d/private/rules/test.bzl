"""D test rule for compiling and running D unit tests."""

load(
    "@bazel_tools//tools/cpp:toolchain_utils.bzl",
    "use_cpp_toolchain",
)
load("//d/private/rules:common.bzl", "TARGET_TYPE", "compilation_action", "runnable_attrs")

def _d_test_impl(ctx):
    """Implementation of d_test rule."""
    return compilation_action(ctx, target_type = TARGET_TYPE.TEST)

d_test = rule(
    implementation = _d_test_impl,
    attrs = runnable_attrs,
    toolchains = ["//d:toolchain_type"] + use_cpp_toolchain(),
    fragments = ["cpp"],
    test = True,
)
