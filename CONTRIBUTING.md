# How to Contribute

## Using devcontainers

If you are using [devcontainers](https://code.visualstudio.com/docs/devcontainers/containers)
and/or [codespaces](https://github.com/features/codespaces) then you can start
contributing immediately and skip the next step.

## Formatting

Starlark files should be formatted by buildifier.
We suggest using a pre-commit hook to automate this.
First [install pre-commit](https://pre-commit.com/#installation),
then run

```shell
pre-commit install
```

Otherwise later tooling on CI will yell at you about formatting/linting violations.

## Updating BUILD files

Some targets are generated from sources.
Currently this is just the `bzl_library` targets.
Run `bazel run //tools:gazelle` to keep them up-to-date.

## Using this as a development dependency of other rules

When developing another module that depends on rules_d, add a local override
in that project's `MODULE.bazel`:

```starlark
local_path_override(
    module_name = "rules_d",
    path = "/absolute/path/to/rules_d",
)
```

The `e2e/smoke` module already uses a local override to test this checkout.

## Releasing

[Release Please](https://github.com/googleapis/release-please) maintains a release
PR as changes land on `main`. A maintainer reviews and merges that PR to release;
this applies to patch, minor, and major releases.

Use Conventional Commit PR titles and squash merges so the resulting commits
carry the intended release information:

- `fix:` bumps the patch version.
- `feat:` bumps the minor version.
- `!` or a `BREAKING CHANGE:` footer bumps the major version, even before 1.0.0.
- Non-releasing changes such as `chore:` normally do not create a release PR.

The release PR updates `CHANGELOG.md`, `version.txt`, and the release manifest.
The root Bazel module uses the development version `0.0.0`.
To override a proposed version, add a `Release-As: X.Y.Z` footer to a commit on
`main` (for example, the squash commit of a PR). Review the updated release PR
before merging it.

The [Release Please workflow](https://github.com/bazel-contrib/rules_d/actions/workflows/release-please.yaml)
runs on pushes to `main` and can also be dispatched manually. After the release
PR is merged, it creates the tag and GitHub Release, then calls the
release workflow to build archives and API documentation, upload
attestations, and publish to BCR. The GitHub Release exists before its assets
finish uploading. Changelog entries and installation instructions are included
in the final release notes.

### Authentication and release PR checks

Release Please uses the built-in `GITHUB_TOKEN`. The repository must allow
GitHub Actions to create pull requests (Settings > Actions > General), subject
to organization policy. BCR publishing requires the `BCR_PUBLISH_TOKEN` secret.

PRs created with `GITHUB_TOKEN` do not automatically trigger other workflows.
After creating or updating a release PR, the workflow dispatches CI on its
branch. CI runs the Bazel matrix and pre-commit checks and reports the
`conclusion` check on the release PR commit. To rerun CI manually, select the
release PR branch in the CI workflow's Run workflow menu.

Release Please generates a Conventional Commit PR title. To run the PR-title
check on a release PR, edit its title or description. This check must pass
before merging if branch protection requires it.

The Release Please workflow calls the release workflow directly for packaging
and BCR publishing. Its tags do not trigger a separate tag-push workflow run.

### Recovery and manual tags

If packaging or asset upload fails after a tag is created, dispatch the
[Release workflow](https://github.com/bazel-contrib/rules_d/actions/workflows/release.yaml)
with that existing tag as `tag_name`. Rerunning Release Please alone does not
retry packaging for an already-created release. If only BCR publication fails,
retry the [Publish to BCR workflow](https://github.com/bazel-contrib/rules_d/actions/workflows/publish.yaml)
with the tag.

Manually pushed version tags trigger the release workflow. Tags without a
matching changelog entry use GitHub-generated release notes alongside the
installation instructions. For example:

```sh
git fetch
git tag v1.0.0 origin/main
git push origin v1.0.0
```

Manual tags use the stable-release and BCR publishing pipeline, including tags
with prerelease suffixes. Merge release PRs for routine releases to keep the
manifest synchronized with published versions.
