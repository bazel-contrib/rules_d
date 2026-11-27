# Changelog

## [0.13.2](https://github.com/bazel-contrib/rules_d/compare/v0.13.1...v0.13.2) (2026-11-27)


### Bug Fixes

* update buildifier to 10.2.0 and resolve lint warnings ([af4871c](https://github.com/bazel-contrib/rules_d/commit/af4871c53968ecbe0bb321d7f545083c337e08f8))

## [0.13.1](https://github.com/bazel-contrib/rules_d/compare/v0.13.0...v0.13.1) (2026-11-18)


### Bug Fixes

* honor disabled features and enable PIC when linking D ([70bc3a8](https://github.com/bazel-contrib/rules_d/commit/70bc3a800515ea8089d47c32a62003d231afadee)), closes [#276](https://github.com/bazel-contrib/rules_d/issues/276)

## [0.13.0](https://github.com/bazel-contrib/rules_d/compare/v0.12.1...v0.13.0) (2026-11-13)


### ⚠ BREAKING CHANGES

* WORKSPACE dependency setup is no longer supported. Use MODULE.bazel and the D and DUB module extensions instead.

### Features

* add dmd-2.114.0 and dmd-2.113.1 ([b18119e](https://github.com/bazel-contrib/rules_d/commit/b18119e08ac0de9341ca7d55f10d3d19cd0b9f95))
* remove WORKSPACE support ([e874615](https://github.com/bazel-contrib/rules_d/commit/e87461568b662fd59f9e103121ff69d791eaa33b))

## Changelog

Releases after v0.12.1 are recorded here. For earlier releases, see the
[GitHub releases](https://github.com/bazel-contrib/rules_d/releases).
