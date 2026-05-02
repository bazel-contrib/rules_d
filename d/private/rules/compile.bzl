"""Compilation action for D rules."""

load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_cc//cc:defs.bzl", "cc_common")
load("@rules_cc//cc/common:cc_info.bzl", "CcInfo")
load("//d/private:providers.bzl", "DInfo")
load("//d/private/rules:utils.bzl", "object_file_name", "static_library_name")

D_FILE_EXTENSIONS = [".d", ".di"]

COMPILATION_MODE_FLAGS = {
    "dbg": ["-debug", "-g"],
    "fastbuild": ["-g"],
    "opt": ["-O", "-release", "-inline"],
}

common_attrs = {
    "srcs": attr.label_list(
        doc = "List of D '.d' or '.di' source files.",
        allow_files = D_FILE_EXTENSIONS,
        allow_empty = False,
    ),
    "deps": attr.label_list(doc = "List of dependencies.", providers = [[CcInfo], [DInfo]]),
    "dopts": attr.string_list(doc = "Compiler flags."),
    "imports": attr.string_list(doc = "List of import paths. Default is the package directory."),
    "linkopts": attr.string_list(doc = "Linker flags passed via -L flags."),
    "string_imports": attr.string_list(doc = "List of string import paths."),
    "string_srcs": attr.label_list(doc = "List of string import source files."),
    "versions": attr.string_list(doc = "List of version identifiers."),
    "_linux_constraint": attr.label(default = "@platforms//os:linux", doc = "Linux platform constraint"),
    "_macos_constraint": attr.label(default = "@platforms//os:macos", doc = "macOS platform constraint"),
    "_windows_constraint": attr.label(default = "@platforms//os:windows", doc = "Windows platform constraint"),
}

runnable_attrs = dicts.add(
    common_attrs,
    {
        "env": attr.string_dict(doc = "Environment variables for the binary at runtime. Subject of location and make variable expansion."),
        "data": attr.label_list(allow_files = True, doc = "List of files to be made available at runtime."),
        "_cc_toolchain": attr.label(
            default = "@rules_cc//cc:current_cc_toolchain",
            doc = "Default CC toolchain, used for linking. Remove after https://github.com/bazelbuild/bazel/issues/7260 is flipped (and support for old Bazel version is not needed)",
        ),
    },
)

library_attrs = dicts.add(
    common_attrs,
    {
        "source_only": attr.bool(doc = "If true, the source files are compiled, but not library is produced."),
    },
)

TARGET_TYPE = struct(
    BINARY = "binary",
    LIBRARY = "library",
    TEST = "test",
)

def d_compile(ctx, target_type = TARGET_TYPE.LIBRARY):
    """Defines a compilation action for D source files.

    Args:
        ctx: The rule context.
        target_type: The type of the target, either 'binary', 'library', or 'test'.
    Returns:
        The DInfo provider containing the compilation information.
    """
    toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info
    c_deps = [d[CcInfo] for d in ctx.attr.deps if CcInfo in d]
    d_deps = [d[DInfo] for d in ctx.attr.deps if DInfo in d]
    compiler_flags = depset(
        ctx.attr.dopts,
        transitive = [d.compiler_flags for d in d_deps],
    )
    imports = depset(
        [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.imports],
        transitive = [d.imports for d in d_deps],
    )
    linker_flags = depset(
        ctx.attr.linkopts,
        transitive = [d.linker_flags for d in d_deps],
    )
    string_imports = depset(
        ([paths.join(ctx.label.workspace_root, ctx.label.package)] if ctx.files.string_srcs else []) +
        [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.string_imports],
        transitive = [d.string_imports for d in d_deps],
    )
    versions = depset(ctx.attr.versions, transitive = [d.versions for d in d_deps])
    args = ctx.actions.args()
    args.add_all(COMPILATION_MODE_FLAGS[ctx.var["COMPILATION_MODE"]])
    args.add_all(ctx.files.srcs)
    args.add_all([i for i in imports.to_list() if i], format_each = "-I=%s")
    args.add_all([si for si in string_imports.to_list() if si], format_each = "-J=%s")
    args.add_all(toolchain.compiler_flags)
    args.add_all(compiler_flags.to_list())
    args.add_all([v for v in versions.to_list() if v], format_each = "-version=%s")
    output = None
    if target_type == TARGET_TYPE.TEST:
        args.add_all(["-main", "-unittest"])
    if target_type == TARGET_TYPE.LIBRARY:
        args.add("-lib")
        output = ctx.actions.declare_file(static_library_name(ctx, ctx.label.name))
        library_to_link = None if ctx.attr.source_only else cc_common.create_library_to_link(
            actions = ctx.actions,
            static_library = output,
        )
    else:
        args.add("-c")
        output = ctx.actions.declare_file(object_file_name(ctx, ctx.label.name))
        library_to_link = None
    args.add(output, format = "-of=%s")

    inputs = depset(
        direct = ctx.files.srcs + ctx.files.string_srcs,
        transitive = [toolchain.d_compiler[DefaultInfo].default_runfiles.files] +
                     [d.interface_srcs for d in d_deps],
    )

    ctx.actions.run(
        inputs = inputs,
        outputs = [output],
        executable = toolchain.d_compiler[DefaultInfo].files_to_run,
        arguments = [args],
        env = ctx.var,
        use_default_shell_env = False,
        mnemonic = "Dcompile",
        progress_message = "Compiling D %s %s" % (target_type, ctx.label.name),
        toolchain = "@rules_d//d:toolchain_type",
    )
    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = [library_to_link] if library_to_link else None),
    )
    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(
            direct = [linker_input],
            transitive = [
                d.linking_context.linker_inputs
                for d in c_deps + d_deps
            ],
        ),
    )
    return DInfo(
        compilation_output = output,
        compiler_flags = compiler_flags,
        imports = depset(
            [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.imports] if ctx.attr.imports else [paths.join(ctx.label.workspace_root, ctx.label.package)],
            transitive = [d.imports for d in d_deps],
        ),
        interface_srcs = depset(
            ctx.files.srcs + ctx.files.string_srcs,
            transitive = [d.interface_srcs for d in d_deps],
        ),
        linking_context = linking_context,
        linker_flags = linker_flags,
        string_imports = depset(
            ([paths.join(ctx.label.workspace_root, ctx.label.package)] if ctx.files.string_srcs else []) +
            [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.string_imports],
            transitive = [d.string_imports for d in d_deps],
        ),
        versions = versions,
    )

def d_proto_compile(ctx, srcs, deps, import_root):
    """Compiles generated D proto sources into a D library.

    Args:
        ctx: The aspect context.
        srcs: Generated D source files to compile.
        deps: Dependency targets providing CcInfo or DInfo.
        import_root: Import path containing the generated D sources.
    Returns:
        The DInfo provider containing the compilation information.
    """
    toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info
    c_deps = [d[CcInfo] for d in deps if CcInfo in d]
    d_deps = [d[DInfo] for d in deps if DInfo in d]
    compiler_flags = depset(transitive = [d.compiler_flags for d in d_deps])
    imports = depset([import_root], transitive = [d.imports for d in d_deps])
    linker_flags = depset(transitive = [d.linker_flags for d in d_deps])
    string_imports = depset(transitive = [d.string_imports for d in d_deps])
    versions = depset(transitive = [d.versions for d in d_deps])

    args = ctx.actions.args()
    args.add_all(COMPILATION_MODE_FLAGS[ctx.var["COMPILATION_MODE"]])
    args.add_all(srcs)
    args.add_all([i for i in imports.to_list() if i], format_each = "-I=%s")
    args.add_all([si for si in string_imports.to_list() if si], format_each = "-J=%s")
    args.add_all(toolchain.compiler_flags)
    args.add_all(compiler_flags.to_list())
    args.add_all([v for v in versions.to_list() if v], format_each = "-version=%s")
    args.add("-lib")

    output = ctx.actions.declare_file(static_library_name(ctx, ctx.label.name))
    args.add(output, format = "-of=%s")

    ctx.actions.run(
        inputs = depset(
            direct = srcs,
            transitive = [toolchain.d_compiler[DefaultInfo].default_runfiles.files] +
                         [d.interface_srcs for d in d_deps],
        ),
        outputs = [output],
        executable = toolchain.d_compiler[DefaultInfo].files_to_run,
        arguments = [args],
        env = ctx.var,
        use_default_shell_env = False,
        mnemonic = "Dcompile",
        progress_message = "Compiling D proto library %s" % ctx.label.name,
        toolchain = "@rules_d//d:toolchain_type",
    )

    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = [cc_common.create_library_to_link(
            actions = ctx.actions,
            static_library = output,
        )]),
    )
    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(
            direct = [linker_input],
            transitive = [
                d.linking_context.linker_inputs
                for d in c_deps + d_deps
            ],
        ),
    )
    return DInfo(
        compilation_output = output,
        compiler_flags = compiler_flags,
        imports = depset(
            [import_root, paths.join(ctx.label.workspace_root, ctx.label.package)],
            transitive = [d.imports for d in d_deps],
        ),
        interface_srcs = depset(srcs, transitive = [d.interface_srcs for d in d_deps]),
        linking_context = linking_context,
        linker_flags = linker_flags,
        string_imports = string_imports,
        versions = versions,
    )
