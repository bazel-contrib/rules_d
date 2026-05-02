"""Rule for generating and compiling D libraries from proto_library targets."""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@protobuf//bazel/common:proto_info.bzl", "ProtoInfo")
load("@rules_cc//cc:defs.bzl", "cc_common")
load("//d/private:providers.bzl", "DInfo")
load("//d/private/rules:compile.bzl", "d_compile")
load("//d/private/rules:utils.bzl", "static_library_name")

_ProtoDFilesInfo = provider(
    doc = "Generated D proto files.",
    fields = {"files": "Generated D source and library files."},
)

def _proto_path(src, proto, package = None):
    if package and src.path.startswith(package + "/"):
        return src.path[len(package) + 1:]
    if proto.proto_source_root == ".":
        prefix = src.root.path + "/"
    elif proto.proto_source_root.startswith(src.root.path):
        prefix = proto.proto_source_root + "/"
    else:
        prefix = paths.join(src.root.path, proto.proto_source_root) + "/"
    if not src.path.startswith(prefix):
        return src.path
    return src.path[len(prefix):]

def _default_out(src):
    if not src.basename.endswith(".proto"):
        fail("Expected a .proto source, got %s" % src.path)
    return src.basename[:-len(".proto")] + ".d"

def _generated_root(ctx):
    if ctx.label.package:
        return paths.join(ctx.bin_dir.path, ctx.label.package)
    return ctx.bin_dir.path

def _empty_d_info(deps):
    d_deps = [d[DInfo] for d in deps if DInfo in d]
    return DInfo(
        compiler_flags = depset(transitive = [d.compiler_flags for d in d_deps]),
        imports = depset(transitive = [d.imports for d in d_deps]),
        interface_srcs = depset(transitive = [d.interface_srcs for d in d_deps]),
        linker_flags = depset(transitive = [d.linker_flags for d in d_deps]),
        linking_context = cc_common.create_linking_context(
            linker_inputs = depset(transitive = [d.linking_context.linker_inputs for d in d_deps]),
        ),
        string_imports = depset(transitive = [d.string_imports for d in d_deps]),
        versions = depset(transitive = [d.versions for d in d_deps]),
    )

def _d_proto_aspect_impl(target, ctx):
    proto = target[ProtoInfo]
    proto_deps = getattr(ctx.rule.attr, "deps", [])
    d_deps = proto_deps + [ctx.attr._runtime]

    if not proto.direct_sources:
        transitive_files = [dep[_ProtoDFilesInfo].files for dep in proto_deps if _ProtoDFilesInfo in dep]
        return [
            _empty_d_info(proto_deps),
            _ProtoDFilesInfo(files = depset(transitive = transitive_files)),
        ]

    direct_sources = []
    proto_inputs = []
    proto_paths = {}
    proto_source_roots = {}
    direct_proto_paths = []

    for root in proto.transitive_proto_path.to_list():
        proto_source_roots[root] = None
    if ctx.label.package:
        proto_source_roots[ctx.label.package] = None
    for src in proto.direct_sources:
        direct_sources.append(src)
        direct_proto_paths.append(_proto_path(src, proto, ctx.label.package))
    for src in proto.transitive_sources.to_list():
        proto_inputs.append(src)
        path = _proto_path(src, proto)
        if path in proto_paths and proto_paths[path] != src:
            fail("proto files %s and %s have the same import path %s" % (
                src.path,
                proto_paths[path].path,
                path,
            ))
        proto_paths[path] = src

    outs = [_default_out(src) for src in direct_sources]
    generated_srcs = [ctx.actions.declare_file(out) for out in outs]
    args = ctx.actions.args()
    args.add("--plugin=protoc-gen-d=%s" % ctx.executable._protoc_gen_d.path)
    args.add("--d_out=%s" % _generated_root(ctx))
    args.add_all(proto_source_roots.keys(), before_each = "--proto_path")
    args.add_all(direct_proto_paths)

    ctx.actions.run(
        inputs = proto_inputs,
        outputs = generated_srcs,
        tools = [
            ctx.attr._protoc[DefaultInfo].files_to_run,
            ctx.attr._protoc_gen_d[DefaultInfo].files_to_run,
        ],
        executable = ctx.executable._protoc,
        arguments = [args],
        mnemonic = "DProtoCompile",
        progress_message = "Generating D sources from proto %s" % ctx.label.name,
    )

    d_info = d_compile(
        actions = ctx.actions,
        label = ctx.label,
        toolchain = ctx.toolchains["//d:toolchain_type"].d_toolchain_info,
        compilation_mode = ctx.var["COMPILATION_MODE"],
        env = ctx.var,
        srcs = generated_srcs,
        deps = d_deps,
        dopts = [],
        imports = [_generated_root(ctx)],
        linkopts = [],
        string_srcs = [],
        string_imports = [],
        versions = [],
        output = ctx.actions.declare_file(static_library_name(ctx, ctx.label.name)),
    )
    transitive_files = [dep[_ProtoDFilesInfo].files for dep in proto_deps if _ProtoDFilesInfo in dep]
    return [
        d_info,
        _ProtoDFilesInfo(files = depset(
            direct = generated_srcs + [d_info.compilation_output],
            transitive = transitive_files,
        )),
    ]

d_proto_aspect = aspect(
    implementation = _d_proto_aspect_impl,
    attr_aspects = ["deps"],
    required_providers = [ProtoInfo],
    provides = [DInfo],
    attrs = {
        "_protoc": attr.label(
            default = "@protobuf//:protoc",
            executable = True,
            cfg = "exec",
        ),
        "_protoc_gen_d": attr.label(
            default = "@protobuf_d//protoc_gen_d:protoc-gen-d",
            executable = True,
            cfg = "exec",
        ),
        "_runtime": attr.label(
            default = "@protobuf_d//:protobuf",
            providers = [DInfo],
        ),
        "_linux_constraint": attr.label(default = "@platforms//os:linux"),
        "_macos_constraint": attr.label(default = "@platforms//os:macos"),
        "_windows_constraint": attr.label(default = "@platforms//os:windows"),
    },
    toolchains = ["//d:toolchain_type"],
)

def _d_proto_library_impl(ctx):
    if len(ctx.attr.deps) != 1:
        fail(
            "'deps' attribute must contain exactly one proto_library label.",
            attr = "deps",
        )
    dep = ctx.attr.deps[0]
    return [
        DefaultInfo(files = dep[_ProtoDFilesInfo].files),
        dep[DInfo],
    ]

d_proto_library = rule(
    implementation = _d_proto_library_impl,
    attrs = {
        "deps": attr.label_list(
            aspects = [d_proto_aspect],
            allow_files = False,
            allow_rules = ["proto_library"],
            doc = "proto_library targets to generate D code from.",
            mandatory = True,
            providers = [ProtoInfo],
        ),
    },
    provides = [DInfo],
)
