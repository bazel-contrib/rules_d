"""Rule for compiling D libraries."""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("//d/private:providers.bzl", "DInfo")
load("//d/private/rules:compile.bzl", "TARGET_TYPE", "d_compile", "library_attrs")
load("//d/private/rules:utils.bzl", "static_library_name")

def _d_library_impl(ctx):
    """Implementation of d_library rule."""
    d_info = d_compile(
        actions = ctx.actions,
        label = ctx.label,
        toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info,
        compilation_mode = ctx.var["COMPILATION_MODE"],
        env = ctx.var,
        srcs = ctx.files.srcs,
        deps = ctx.attr.deps,
        dopts = ctx.attr.dopts,
        imports = [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.imports],
        linkopts = ctx.attr.linkopts,
        string_srcs = ctx.files.string_srcs,
        string_imports = ([paths.join(ctx.label.workspace_root, ctx.label.package)] if ctx.files.string_srcs else []) +
                         [paths.join(ctx.label.workspace_root, ctx.label.package, imp) for imp in ctx.attr.string_imports],
        versions = ctx.attr.versions,
        output = ctx.actions.declare_file(static_library_name(ctx, ctx.label.name)),
        target_type = TARGET_TYPE.LIBRARY,
        source_only = ctx.attr.source_only,
    )
    return [
        d_info,
        DefaultInfo(files = depset([d_info.compilation_output])),
    ]

d_library = rule(
    implementation = _d_library_impl,
    attrs = library_attrs,
    toolchains = ["//d:toolchain_type"],
    provides = [DInfo],
)
