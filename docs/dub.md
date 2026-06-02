# Using rules_d from a DUB project

This tutorial shows how to bring an existing DUB project into Bazel with
`rules_d`. It covers the core setup, DUB dependency locking, hand-written
BUILD targets, and the `gazelle_d` workflow that can generate most BUILD files
for you.

## Start with Bzlmod

Create a `MODULE.bazel` at the root of your project. This is Bazel's module
file, similar in role to `dub.json` for DUB packages. Pick a module name for
your project and add `rules_d`. Use the latest published `rules_d` version
from the [Bazel Central Registry](https://registry.bazel.build/modules/rules_d).
If you are new to Bazel, the official
[Bazel C++ tutorial](https://bazel.build/start/cpp) is a good short
introduction to packages, targets, labels, and `BUILD.bazel` files.

```starlark
module(
    name = "my_d_project",
    version = "0.1.0",
)

bazel_dep(name = "rules_d", version = "0.10.1")

d = use_extension("@rules_d//d:extensions.bzl", "d")
d.toolchain(d_version = "dmd-2.112.0")
d.toolchain(d_version = "ldc-1.41.0")
use_repo(d, "d_toolchains")

register_toolchains("@d_toolchains//:all")
```

The toolchain extension selects the first listed compiler that supports the
current host platform. Listing both DMD and LDC is useful when you want the
same module file to work on more than one platform.

## Lock DUB Dependencies

If your project already has `dub.json`, `dub.sdl`, or `dub.selections.json`,
add a root `BUILD.bazel` target that turns those inputs into the lock file
`rules_d` uses.

```starlark
load("@rules_d//dub:defs.bzl", "dub_lock_dependencies")

dub_lock_dependencies(
    name = "dub_dependencies",
    srcs = ["dub.json"],
    dub_selections_lock = "dub.selections.lock.json",
)
```

If your project already checks in DUB's selections file, use that file instead:

```starlark
dub_lock_dependencies(
    name = "dub_dependencies",
    srcs = ["dub.selections.json"],
    dub_selections_lock = "dub.selections.lock.json",
)
```

Generate or refresh the `rules_d` lock file:

```sh
bazel run //:dub_dependencies.update
```

Check in `dub.selections.lock.json`. It records the resolved DUB packages and
the generated Bazel BUILD content for them.

## Register the DUB Repository

Wire the generated lock file into `MODULE.bazel`:

```starlark
dub = use_extension("@rules_d//dub:extensions.bzl", "dub")
dub.from_dub_selections(
    dub_selections_lock = "//:dub.selections.lock.json",
)
use_repo(dub, "dub")
```

DUB packages are now available as Bazel labels under the `@dub` repository.
For example, the DUB package `semver` is referenced as `@dub//semver`.

## Write BUILD Targets

If you do not use `gazelle_d`, write Bazel targets for your D code directly.
For a conventional DUB layout with application code under `source/`, a small
BUILD file can look like this:

```starlark
load("@rules_d//d:defs.bzl", "d_binary", "d_library", "d_test")

d_library(
    name = "app_lib",
    srcs = glob(["source/**/*.d"], exclude = ["source/app.d"]),
    imports = ["source"],
    deps = [
        "@dub//semver",
    ],
)

d_binary(
    name = "app",
    srcs = ["source/app.d"],
    imports = ["source"],
    deps = [":app_lib"],
)

d_test(
    name = "app_test",
    srcs = glob(["source/**/*.d"], exclude = ["source/app.d"]),
    imports = ["source"],
    deps = [
        "@dub//semver",
    ],
)
```

Build, test, and run the project with Bazel:

```sh
bazel build //...
bazel test //...
bazel run //:app
```

## How DUB Concepts Map to Bazel

- DUB registry dependencies become labels in the `@dub` repository, such as
  `@dub//vibe-d` or `@dub//semver`.
- D source roots become `srcs` and `imports` on `d_library`, `d_binary`, and
  `d_test`.
- DUB `versions` become the `versions` attribute.
- DUB platform libraries become `linkopts`; platform-specific libraries can be
  represented with Bazel `select`.
- `rules_d` links D binaries and tests through the C++ linker, so C++ and D
  interoperability is the best-supported mixed-language path.
- DUB configurations and build types do not map one-to-one to Bazel. Model the
  binaries, libraries, and tests that you actually want to build as explicit
  Bazel targets.

## Generate BUILD Files with gazelle_d

`gazelle_d` is a Gazelle language extension for `rules_d`. It is released as
a separate module in the
[Bazel Central Registry](https://registry.bazel.build/modules/gazelle_d). It
scans D sources and DUB manifests, then generates:

- `d_library` targets for package sources.
- `d_binary` targets for source files containing a D `main`.
- `d_test` targets for files containing `unittest` blocks.
- `d_proto_library` targets for generated `proto_library` targets.
- `dub_lock_dependencies` targets for DUB dependency lock files.

For most DUB projects, start with `gazelle_d` and then keep hand-written
changes only where the generated BUILD files need project-specific tuning.

Add `gazelle` and `gazelle_d` beside `rules_d` in `MODULE.bazel`. Use the
latest published `gazelle_d` version from the Bazel Central Registry.

```starlark
bazel_dep(name = "gazelle", version = "0.51.0")
bazel_dep(name = "gazelle_d", version = "0.1.1")
```

Add a root `BUILD.bazel` target for a Gazelle binary that embeds the D
extension:

```starlark
load("@gazelle//:def.bzl", "gazelle", "gazelle_binary")

gazelle_binary(
    name = "gazelle_d",
    languages = ["@gazelle_d//d"],
)

gazelle(
    name = "gazelle",
    gazelle = ":gazelle_d",
)
```

Generate BUILD files, then refresh the DUB lock file:

```sh
bazel run //:gazelle
bazel run //:dub_dependencies.update
```

When run at the repository root, `gazelle_d` emits a target named
`dub_dependencies`. Its `srcs` include discovered `dub.json`, `dub.sdl`, and
`dub.selections.json` files. If a directory has `dub.selections.json`,
`gazelle_d` uses that instead of the sibling DUB recipe.

Generated D targets reference DUB registry packages through the default
`@dub` repository, so keep the `dub.from_dub_selections` setup in
`MODULE.bazel`.
