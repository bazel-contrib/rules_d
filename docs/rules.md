<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API of D rules.

<a id="d_library"></a>

## d_library

<pre>
load("@rules_d//d:defs.bzl", "d_library")

d_library(<a href="#d_library-name">name</a>, <a href="#d_library-deps">deps</a>, <a href="#d_library-srcs">srcs</a>, <a href="#d_library-source_only">source_only</a>, <a href="#d_library-string_srcs">string_srcs</a>, <a href="#d_library-versions">versions</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="d_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="d_library-deps"></a>deps |  List of dependencies.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_library-srcs"></a>srcs |  List of D '.d' or '.di' source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_library-source_only"></a>source_only |  If true, the source files are compiled, but not library is produced.   | Boolean | optional |  `False`  |
| <a id="d_library-string_srcs"></a>string_srcs |  List of string import source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_library-versions"></a>versions |  List of version identifiers.   | List of strings | optional |  `[]`  |


<a id="d_test"></a>

## d_test

<pre>
load("@rules_d//d:defs.bzl", "d_test")

d_test(<a href="#d_test-name">name</a>, <a href="#d_test-deps">deps</a>, <a href="#d_test-srcs">srcs</a>, <a href="#d_test-string_srcs">string_srcs</a>, <a href="#d_test-versions">versions</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="d_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="d_test-deps"></a>deps |  List of dependencies.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_test-srcs"></a>srcs |  List of D '.d' or '.di' source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_test-string_srcs"></a>string_srcs |  List of string import source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="d_test-versions"></a>versions |  List of version identifiers.   | List of strings | optional |  `[]`  |


