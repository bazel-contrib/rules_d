"""Rule/macro to manage the dub dependencies lock file."""

load("@bazel_lib//lib:run_binary.bzl", "run_binary")
load("@bazel_lib//lib:utils.bzl", "propagate_common_rule_attributes")
load("@bazel_lib//lib:write_source_files.bzl", "write_source_file")

def dub_lock_dependencies(
        name,
        srcs = None,
        dub_selections_lock = None,
        skip_ssl_verification = False,
        verbose = False,
        **kwargs):
    """Generates a dub dependencies lock file suitable for bazel use.

    Args:
        name: The dub dependencies target.
        srcs: list of files containing the dub dependencies. Supported inputs are:
            * dub.sdl
            * dub.json
            * dub.selections.json
        dub_selections_lock: The output lock file. If not specified, defaults to `{name}.lock.json`.
        skip_ssl_verification: If true, SSL certificate verification will be skipped when downloading dependencies. Use with caution!
        verbose: If true, verbose output will be displayed during the generation process.
        **kwargs: Additional keyword arguments passed to the `_test` rule.
    """
    update_target_name = name + ".update"
    if not dub_selections_lock:
        dub_selections_lock = name + ".lock.json"
    out_file = "_" + dub_selections_lock
    if "tags" not in kwargs:
        kwargs["tags"] = ["local"]
    elif "local" not in kwargs["tags"]:
        kwargs["tags"].append("local")
    run_binary(
        name = name,
        tool = "@rules_d//dub/selections_lock:generate_selections_lock",
        srcs = srcs + ["@rules_d//d:dub"],
        args = [
            "--bazel_generating_target=//{}:{}".format(native.package_name(), update_target_name),
            "--output=$(location {})".format(out_file),
            "--skip_ssl_verification={}".format(skip_ssl_verification),
            "--verbose={}".format(verbose),
        ] + ["--input=$(location {})".format(src) for src in srcs],
        env = {
            "DUB": "$(location @rules_d//d:dub)",
        },
        outs = [out_file],
        progress_message = "Generating dub selections lock file...",
        **propagate_common_rule_attributes(kwargs)
    )
    write_source_file(
        name = update_target_name,
        in_file = ":" + name,
        out_file = dub_selections_lock,
        diff_test_failure_message = "The dub selections lock file '{}' is out of date. Please run 'bazel run {{TARGET}}' to update it.",
        file_missing_failure_message = "The dub selections lock file '{}' is missing. Please run 'bazel run {{TARGET}}' to generate it.",
        **propagate_common_rule_attributes(kwargs)
    )
