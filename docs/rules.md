<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API of D rules.

<a id="d_binary"></a>

## d_binary

<pre>
load("@rules_d//d:defs.bzl", "d_binary")

d_binary(<a href="#d_binary-name">name</a>, <a href="#d_binary-deps">deps</a>, <a href="#d_binary-srcs">srcs</a>, <a href="#d_binary-dopts">dopts</a>, <a href="#d_binary-imports">imports</a>, <a href="#d_binary-linkopts">linkopts</a>, <a href="#d_binary-string_imports">string_imports</a>, <a href="#d_binary-string_srcs">string_srcs</a>, <a href="#d_binary-versions">versions</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="d_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="d_binary-deps"></a>deps |  List of dependencies.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_binary-srcs"></a>srcs |  List of D '.d' or '.di' source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_binary-dopts"></a>dopts |  Compiler flags.   | List of strings | optional |  `[]`  |
| <a id="d_binary-imports"></a>imports |  List of import paths.   | List of strings | optional |  `[]`  |
| <a id="d_binary-linkopts"></a>linkopts |  Linker flags passed via -L flags.   | List of strings | optional |  `[]`  |
| <a id="d_binary-string_imports"></a>string_imports |  List of string import paths.   | List of strings | optional |  `[]`  |
| <a id="d_binary-string_srcs"></a>string_srcs |  List of string import source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_binary-versions"></a>versions |  List of version identifiers.   | List of strings | optional |  `[]`  |


<a id="d_library"></a>

## d_library

<pre>
load("@rules_d//d:defs.bzl", "d_library")

d_library(<a href="#d_library-name">name</a>, <a href="#d_library-deps">deps</a>, <a href="#d_library-srcs">srcs</a>, <a href="#d_library-dopts">dopts</a>, <a href="#d_library-imports">imports</a>, <a href="#d_library-linkopts">linkopts</a>, <a href="#d_library-source_only">source_only</a>, <a href="#d_library-string_imports">string_imports</a>, <a href="#d_library-string_srcs">string_srcs</a>,
          <a href="#d_library-versions">versions</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="d_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="d_library-deps"></a>deps |  List of dependencies.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_library-srcs"></a>srcs |  List of D '.d' or '.di' source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_library-dopts"></a>dopts |  Compiler flags.   | List of strings | optional |  `[]`  |
| <a id="d_library-imports"></a>imports |  List of import paths.   | List of strings | optional |  `[]`  |
| <a id="d_library-linkopts"></a>linkopts |  Linker flags passed via -L flags.   | List of strings | optional |  `[]`  |
| <a id="d_library-source_only"></a>source_only |  If true, the source files are compiled, but not library is produced.   | Boolean | optional |  `False`  |
| <a id="d_library-string_imports"></a>string_imports |  List of string import paths.   | List of strings | optional |  `[]`  |
| <a id="d_library-string_srcs"></a>string_srcs |  List of string import source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_library-versions"></a>versions |  List of version identifiers.   | List of strings | optional |  `[]`  |


<a id="d_test"></a>

## d_test

<pre>
load("@rules_d//d:defs.bzl", "d_test")

d_test(<a href="#d_test-name">name</a>, <a href="#d_test-deps">deps</a>, <a href="#d_test-srcs">srcs</a>, <a href="#d_test-dopts">dopts</a>, <a href="#d_test-imports">imports</a>, <a href="#d_test-linkopts">linkopts</a>, <a href="#d_test-string_imports">string_imports</a>, <a href="#d_test-string_srcs">string_srcs</a>, <a href="#d_test-versions">versions</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="d_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="d_test-deps"></a>deps |  List of dependencies.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_test-srcs"></a>srcs |  List of D '.d' or '.di' source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_test-dopts"></a>dopts |  Compiler flags.   | List of strings | optional |  `[]`  |
| <a id="d_test-imports"></a>imports |  List of import paths.   | List of strings | optional |  `[]`  |
| <a id="d_test-linkopts"></a>linkopts |  Linker flags passed via -L flags.   | List of strings | optional |  `[]`  |
| <a id="d_test-string_imports"></a>string_imports |  List of string import paths.   | List of strings | optional |  `[]`  |
| <a id="d_test-string_srcs"></a>string_srcs |  List of string import source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_test-versions"></a>versions |  List of version identifiers.   | List of strings | optional |  `[]`  |


