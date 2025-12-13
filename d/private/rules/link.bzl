"""
Linking action for D rules.

"""

load("@bazel_lib//lib:expand_make_vars.bzl", "expand_variables")
load("@rules_cc//cc:defs.bzl", "cc_common")
load("@rules_cc//cc/common:cc_info.bzl", "CcInfo")
load("//d/private/rules:cc_toolchain.bzl", "find_cc_toolchain_for_linking")

def link_action(ctx, d_info):
    """Linking action for D rules.

    Args:
        ctx: The rule context.
        d_info: The DInfo provider containing the linking context.
    Returns:
        List of providers:
            - DefaultInfo: The linked binary.
            - RunEnvironmentInfo: The environment variables for the linked binary.
    """
    toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info
    cc_linker_info = find_cc_toolchain_for_linking(ctx)
    linking_contexts = [
        d_info.linking_context,
        toolchain.libphobos[CcInfo].linking_context,
    ] + ([toolchain.druntime[CcInfo].linking_context] if toolchain.druntime else [])
    compilation_outputs = cc_common.create_compilation_outputs(
        objects = depset(direct = [d_info.compilation_output]),
    )
    res = cc_common.link(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = cc_linker_info.feature_configuration,
        cc_toolchain = cc_linker_info.cc_toolchain,
        compilation_outputs = compilation_outputs,
        linking_contexts = linking_contexts,
        user_link_flags = toolchain.linker_flags + ctx.attr.linkopts + d_info.linker_flags.to_list(),
    )
    output = res.executable
    env_with_expansions = {
        k: expand_variables(ctx, ctx.expand_location(v, ctx.files.data), [output], "env")
        for k, v in ctx.attr.env.items()
    }
    return [
        DefaultInfo(
            executable = output,
            runfiles = ctx.runfiles(files = ctx.files.data),
        ),
        RunEnvironmentInfo(environment = env_with_expansions),
    ]
