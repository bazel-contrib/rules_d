"""D test rule for compiling and running D unit tests."""

load("@bazel_lib//lib:expand_make_vars.bzl", "expand_variables")
load("@rules_cc//cc:find_cc_toolchain.bzl", "use_cc_toolchain")
load("//d/private/rules:compile.bzl", "TARGET_TYPE", "d_compile", "runnable_attrs")
load("//d/private/rules:link.bzl", "link_action")

def _d_test_impl(ctx):
    """Implementation of d_test rule."""
    d_info = d_compile(ctx, target_type = TARGET_TYPE.TEST)
    output = link_action(ctx, d_info)
    env_with_expansions = {
        k: expand_variables(ctx, ctx.expand_location(v, ctx.attr.data), [output], "env")
        for k, v in ctx.attr.env.items()
    }
    return [
        DefaultInfo(
            executable = output,
            runfiles = ctx.runfiles(files = ctx.files.data),
        ),
        RunEnvironmentInfo(environment = env_with_expansions),
    ]

d_test = rule(
    implementation = _d_test_impl,
    attrs = runnable_attrs,
    toolchains = ["//d:toolchain_type"] + use_cc_toolchain(),
    fragments = ["cpp"],
    test = True,
)
