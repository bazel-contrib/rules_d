# Bazel Rules for the [D Programming Language](https://dlang.org)

`rules_d` provides Bazel rules and toolchains for building D libraries,
binaries, tests, protocol buffers, and projects that depend on DUB packages.

## Documentation

- [API documentation](https://registry.bazel.build/docs/rules_d)
- [Bazel Central Registry module](https://registry.bazel.build/modules/rules_d)
- [Releases](https://github.com/bazel-contrib/rules_d/releases)

## Tutorials

- [Using rules_d from a DUB project](docs/dub.md)

## Installation

With Bzlmod, add `rules_d` to your `MODULE.bazel`:

```starlark
bazel_dep(name = "rules_d", version = "<version>")
```

Then configure a D toolchain:

```starlark
d = use_extension("@rules_d//d:extensions.bzl", "d")
d.toolchain(d_version = "dmd-2.112.0")
use_repo(d, "d_toolchains")

register_toolchains("@d_toolchains//:all")
```

Use the latest published version from the
[Bazel Central Registry](https://registry.bazel.build/modules/rules_d).

## WORKSPACE

For legacy `WORKSPACE` projects, copy the snippet from the release notes for
the version you want to use.

To use a commit instead of a release, point `http_archive` at a GitHub source
archive such as `https://github.com/bazel-contrib/rules_d/archive/<sha>.tar.gz`,
set `strip_prefix = "rules_d-<sha>"`, and update the checksum.
