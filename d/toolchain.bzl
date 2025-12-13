"""This module implements the D toolchain rule.
"""

DToolchainInfo = provider(
    doc = "D compiler information.",
    fields = {
        "compiler_flags": "Default compiler flags.",
        "d_compiler": "The D compiler executable.",
        "druntime": "The D runtime library. (LDC only)",
        "dub_tool": "The dub package manager executable.",
        "libphobos": "The Phobos library.",
        "linker_flags": "Default linker flags.",
        "rdmd_tool": "The rdmd compile and execute utility.",
    },
)

def _expand_toolchain_variables(ctx, input):
    """Expand toolchain variables in the input string."""
    d_compiler_root = ctx.attr.d_compiler.label.workspace_root
    return input.format(D_COMPILER_ROOT = d_compiler_root)

def _d_toolchain_impl(ctx):
    d_compiler_files = []
    dub_tool_files = []
    rdmd_tool_files = []

    if ctx.attr.d_compiler:
        d_compiler_files = ctx.attr.d_compiler.files.to_list() + ctx.attr.d_compiler.default_runfiles.files.to_list()
    if ctx.attr.dub_tool:
        dub_tool_files = ctx.attr.dub_tool.files.to_list() + ctx.attr.dub_tool.default_runfiles.files.to_list()
    if ctx.attr.rdmd_tool:
        rdmd_tool_files = ctx.attr.rdmd_tool.files.to_list() + ctx.attr.rdmd_tool.default_runfiles.files.to_list()

    # Make the $(tool_BIN) variable available in places like genrules.
    # See https://docs.bazel.build/versions/main/be/make-variables.html#custom_variables
    template_variables = platform_common.TemplateVariableInfo({
        "DC": ctx.attr.d_compiler.files_to_run.executable.path,
        "DUB": ctx.attr.dub_tool.files_to_run.executable.path,
    })

    default = DefaultInfo(
        files = depset(d_compiler_files + dub_tool_files + rdmd_tool_files),
        runfiles = ctx.runfiles(files = d_compiler_files + dub_tool_files + rdmd_tool_files),
    )
    d_toolchain_info = DToolchainInfo(
        compiler_flags = [_expand_toolchain_variables(ctx, flag) for flag in ctx.attr.compiler_flags],
        d_compiler = ctx.attr.d_compiler,
        dub_tool = ctx.attr.dub_tool,
        linker_flags = [_expand_toolchain_variables(ctx, flag) for flag in ctx.attr.linker_flags],
        rdmd_tool = ctx.attr.rdmd_tool,
        druntime = ctx.attr.druntime,
        libphobos = ctx.attr.libphobos,
    )

    # Export all the providers inside our ToolchainInfo
    # so the resolved_toolchain rule can grab and re-export them.
    toolchain_info = platform_common.ToolchainInfo(
        default = default,
        d_toolchain_info = d_toolchain_info,
        template_variables = template_variables,
    )
    return [
        default,
        toolchain_info,
        template_variables,
    ]

d_toolchain = rule(
    implementation = _d_toolchain_impl,
    attrs = {
        "compiler_flags": attr.string_list(
            doc = "Compiler flags.",
        ),
        "d_compiler": attr.label(
            doc = "The D compiler.",
            executable = True,
            mandatory = True,
            cfg = "exec",
        ),
        "druntime": attr.label(
            doc = "The D runtime library.",
        ),
        "dub_tool": attr.label(
            doc = "The dub package manager.",
            executable = True,
            cfg = "exec",
        ),
        "libphobos": attr.label(
            doc = "The Phobos library.",
        ),
        "linker_flags": attr.string_list(
            doc = "Linker flags.",
        ),
        "rdmd_tool": attr.label(
            doc = "The rdmd compile and execute utility.",
            executable = True,
            cfg = "exec",
        ),
    },
    doc = """Defines a d compiler/runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.
""",
)
