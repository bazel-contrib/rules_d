"""Common definitions for D rules."""

load("@bazel_lib//lib:expand_make_vars.bzl", "expand_variables")
load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_cc//cc/common:cc_info.bzl", "CcInfo")
load("//d/private:providers.bzl", "DInfo")
load("//d/private/rules:cc_toolchain.bzl", "find_cc_toolchain_for_linking")

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
    "imports": attr.string_list(doc = "List of import paths."),
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

def _get_os(ctx):
    if ctx.target_platform_has_constraint(ctx.attr._linux_constraint[platform_common.ConstraintValueInfo]):
        return "linux"
    elif ctx.target_platform_has_constraint(ctx.attr._macos_constraint[platform_common.ConstraintValueInfo]):
        return "macos"
    elif ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo]):
        return "windows"
    else:
        fail("OS not supported")

def _binary_name(ctx, name):
    """Returns the name of the binary based on the OS.

    Args:
        ctx: The rule context.
        name: The base name of the binary.
    Returns:
        The name of the binary file.
    """
    os = _get_os(ctx)
    if os == "linux" or os == "macos":
        return name
    elif os == "windows":
        return name + ".exe"
    else:
        fail("Unsupported os %s for binary: %s" % (os, name))

def _static_library_name(ctx, name):
    """Returns the name of the static library based on the OS.

    Args:
        ctx: The rule context.
        name: The base name of the library.
    Returns:
        The name of the static library file.
    """
    os = _get_os(ctx)
    if os == "linux" or os == "macos":
        return "lib" + name + ".a"
    elif os == "windows":
        return name + ".lib"
    else:
        fail("Unsupported os %s for static library: %s" % (os, name))

TARGET_TYPE = struct(
    BINARY = "binary",
    LIBRARY = "library",
    TEST = "test",
)

def compilation_action(ctx, target_type = TARGET_TYPE.LIBRARY):
    """Defines a compilation action for D source files.

    Args:
        ctx: The rule context.
        target_type: The type of the target, either 'binary', 'library', or 'test'.
    Returns:
        The provider containing the compilation information.
    """
    toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info
    cc_deps = [d[CcInfo] for d in ctx.attr.deps if CcInfo in d]
    cc_linker_inputs = [
        linker_input
        for dep in cc_deps
        for linker_input in dep.linking_context.linker_inputs.to_list()
    ]
    cc_libraries = depset([
        lib.pic_static_library if lib.pic_static_library else lib.static_library
        for li in cc_linker_inputs
        for lib in li.libraries
    ], order = "topological")
    fix_linker_flags = {
        "-pthread": "-lpthread",
    }
    cc_linker_flags = depset([
        fix_linker_flags.get(flag, flag)
        for li in cc_linker_inputs
        for flag in li.user_link_flags
    ])
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
        transitive = [d.linker_flags for d in d_deps] + [cc_linker_flags],
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
    args.add_all(imports.to_list(), format_each = "-I=%s")
    args.add_all(string_imports.to_list(), format_each = "-J=%s")
    args.add_all(toolchain.compiler_flags)
    args.add_all(compiler_flags.to_list())
    args.add_all(versions.to_list(), format_each = "-version=%s")
    output = None
    cc_toolchain = None
    env = ctx.var
    if target_type in [TARGET_TYPE.BINARY, TARGET_TYPE.TEST]:
        args.add_all(toolchain.linker_flags)
        args.add_all(linker_flags.to_list(), format_each = "-L=%s")
        for dep in d_deps:
            args.add_all(dep.libraries)
        args.add_all(cc_libraries)
        if target_type == TARGET_TYPE.TEST:
            args.add_all(["-main", "-unittest"])
        output = ctx.actions.declare_file(_binary_name(ctx, ctx.label.name))
        args.add(output, format = "-of=%s")
        cc_linker_info = find_cc_toolchain_for_linking(ctx)
        env = dict(cc_linker_info.env)
        env.update({
            "CC": cc_linker_info.cc_compiler,  # Have to use the env variable here, since DMD doesn't support -gcc= flag
            # Ok, this is a bit weird. Local toolchain from rules_cc works fine if we don't set PATH here.
            # But doesn't work if we set it to an empty string.
            # OTOH the toolchain from toolchains_llvm doesn't work without setting PATH here. (Can't find the linker executable)
            # Even though the cc_wrapper script adds "/usr/bin" to the PATH variable,
            # it only works if the PATH is already in the environment. (I think they have to `export`)
            # So toolchains_llvm works if we set PATH to "" but doesn't work if we don't set it at all.
            # So, to get to a common ground, we set PATH to something generic.
            "PATH": "/bin:/usr/bin:/usr/local/bin",
        })
        if _get_os(ctx) != "windows":
            # DMD doesn't support -Xcc on Windows
            args.add_all(cc_linker_info.cc_linking_options, format_each = "-Xcc=%s")
        cc_toolchain = cc_linker_info.cc_toolchain
    elif target_type == TARGET_TYPE.LIBRARY:
        args.add("-lib")
        output = ctx.actions.declare_file(_static_library_name(ctx, ctx.label.name))
        args.add(output, format = "-of=%s")
    else:
        fail("Unsupported target type: %s" % target_type)

    transitive_library_inputs = []
    if target_type != TARGET_TYPE.LIBRARY:
        transitive_library_inputs += [d.libraries for d in d_deps] + [cc_libraries]
    inputs = depset(
        direct = ctx.files.srcs + ctx.files.string_srcs,
        transitive = [toolchain.d_compiler[DefaultInfo].default_runfiles.files] +
                     [d.interface_srcs for d in d_deps] +
                     transitive_library_inputs,
    )

    ctx.actions.run(
        inputs = inputs,
        tools = [cc_toolchain.all_files] if cc_toolchain else [],
        outputs = [output],
        executable = toolchain.d_compiler[DefaultInfo].files_to_run,
        arguments = [args],
        env = env,
        use_default_shell_env = False,
        mnemonic = "Dcompile",
        progress_message = "Compiling D %s %s" % (target_type, ctx.label.name),
    )
    if target_type == TARGET_TYPE.LIBRARY:
        return [
            DefaultInfo(files = depset([output])),
            DInfo(
                compiler_flags = compiler_flags,
                imports = depset(
                    [paths.join(ctx.label.workspace_root, ctx.label.package)] +
                    [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.imports],
                    transitive = [d.imports for d in d_deps],
                ),
                interface_srcs = depset(
                    ctx.files.srcs + ctx.files.string_srcs,
                    transitive = [d.interface_srcs for d in d_deps],
                ),
                libraries = depset(
                    [] if ctx.attr.source_only else [output],
                    order = "topological",
                    transitive = [d.libraries for d in d_deps] + [cc_libraries],
                ),
                linker_flags = linker_flags,
                string_imports = depset(
                    ([paths.join(ctx.label.workspace_root, ctx.label.package)] if ctx.files.string_srcs else []) +
                    [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.string_imports],
                    transitive = [d.string_imports for d in d_deps],
                ),
                versions = versions,
            ),
        ]
    else:
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
