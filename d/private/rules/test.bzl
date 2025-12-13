"""D test rule for compiling and running D unit tests."""

load("@rules_cc//cc:find_cc_toolchain.bzl", "use_cc_toolchain")
load("//d/private/rules:compile.bzl", "TARGET_TYPE", "compilation_action", "runnable_attrs")
load("//d/private/rules:link.bzl", "link_action")

def _d_test_impl(ctx):
    """Implementation of d_test rule."""
    d_info = compilation_action(ctx, target_type = TARGET_TYPE.TEST)
    return link_action(ctx, d_info)

d_test = rule(
    implementation = _d_test_impl,
    attrs = runnable_attrs,
    toolchains = ["//d:toolchain_type"] + use_cc_toolchain(),
    fragments = ["cpp"],
    test = True,
)
