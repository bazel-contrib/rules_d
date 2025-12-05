"""
Helper functions to extract the C++ toolchain and linker options for linking.
"""

load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "CPP_LINK_EXECUTABLE_ACTION_NAME",
)
load(
    "@bazel_tools//tools/cpp:toolchain_utils.bzl",
    "find_cpp_toolchain",
)
load("@rules_cc//cc/common:cc_common.bzl", "cc_common")

_UNSUPPORTED_FEATURES = [
    # These toolchain features require special rule support and will thus break
    # with D.
    # Taken from rules_go
    "thin_lto",
    "module_maps",
    "use_header_modules",
    "fdo_instrument",
    "fdo_optimize",
    # This is a nonspecific unsupported feature which allows the authors of C++
    # toolchain to apply separate flags when compiling D code.
    "rules_d_unsupported_feature",
]

_LINKER_OPTIONS_DENYLIST = {
    # Don't link C++ libraries
    "-lstdc++": None,
    "-lc++": None,
    "-lc++abi": None,
    # libm and libobjc are added by the D compiler already, so suppress them here, to avoid warnings
    "-lm": None,
    "-lobjc": None,
    "-fobjc-link-runtime": None,
    # --target is passed by the D compiler
    "--target=": None,
    # --target passed by the D compiler conflicts with -mmacosx-version-min set by cc_toolchain
    "-mmacosx-version-min=": None,
}

def _match_option(option, pattern):
    if pattern.endswith("="):
        return option.startswith(pattern)
    else:
        return option == pattern

def _filter_options(options, denylist):
    return [
        option
        for option in options
        if not any([_match_option(option, pattern) for pattern in denylist])
    ]

def find_cc_toolchain_for_linking(ctx):
    """
    Find the C++ toolchain and linker options for linking.

    Args:
      ctx: The rule context
    Returns:
      A struct with the following fields:
        - cc_toolchain: The C++ toolchain
        - cc_compiler: The C/C++ compiler
        - cc_linking_options: The linker options
        - env: The environment variables to set for the linker
    """
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        unsupported_features = _UNSUPPORTED_FEATURES,
    )
    linker_variables = cc_common.create_link_variables(
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        is_linking_dynamic_library = False,
    )
    cc_compiler = cc_common.get_tool_for_action(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_EXECUTABLE_ACTION_NAME,
    )
    cc_linking_options = _filter_options(cc_common.get_memory_inefficient_command_line(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_EXECUTABLE_ACTION_NAME,
        variables = linker_variables,
    ), _LINKER_OPTIONS_DENYLIST)
    env = cc_common.get_environment_variables(
        feature_configuration = feature_configuration,
        action_name = CPP_LINK_EXECUTABLE_ACTION_NAME,
        variables = linker_variables,
    )

    return struct(
        cc_toolchain = cc_toolchain,
        cc_compiler = cc_compiler,
        cc_linking_options = cc_linking_options,
        env = env,
    )
