"""
Linking action for D rules.

"""

load("@rules_cc//cc:defs.bzl", "cc_common")
load("@rules_cc//cc/common:cc_info.bzl", "CcInfo")
load("//d/private/rules:cc_toolchain.bzl", "find_cc_toolchain_for_linking")

def link_action(ctx, d_info):
    """Linking action for D rules.

    Args:
        ctx: The rule context.
        d_info: The DInfo provider containing the linking context.
    Returns:
        A File for the linked binary.
    """
    toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info
    cc_linker_info = find_cc_toolchain_for_linking(ctx)
    linking_contexts = [
        d_info.linking_context,
        toolchain.libphobos[CcInfo].linking_context,
    ] + ([toolchain.druntime[CcInfo].linking_context] if toolchain.druntime else [])
    compilation_outputs = cc_common.create_compilation_outputs(
        objects = depset(direct = [d_info.compilation_output]),
        pic_objects = depset(direct = [d_info.compilation_output]),
    )
    return cc_common.link(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = cc_linker_info.feature_configuration,
        cc_toolchain = cc_linker_info.cc_toolchain,
        compilation_outputs = compilation_outputs,
        linking_contexts = linking_contexts,
        user_link_flags = toolchain.linker_flags + ctx.attr.linkopts + d_info.linker_flags.to_list(),
    ).executable
