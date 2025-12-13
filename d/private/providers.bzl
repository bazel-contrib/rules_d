"""Module containing definitions of D providers."""

def _dinfo_init(
        *,
        compilation_output = None,
        compiler_flags = None,
        imports = None,
        interface_srcs = None,
        linker_flags = None,
        linking_context = None,
        source_only = False,
        string_imports = None,
        versions = None):
    """Initializes the DInfo provider."""
    return {
        "compilation_output": compilation_output,
        "compiler_flags": compiler_flags or depset(),
        "imports": imports or depset(),
        "interface_srcs": interface_srcs or depset(),
        "linker_flags": linker_flags or depset(),
        "linking_context": linking_context or depset(),
        "source_only": source_only,
        "string_imports": string_imports or depset(),
        "versions": versions or depset(),
    }

DInfo, _new_dinfo = provider(
    doc = "Provider containing D compilation information",
    fields = {
        "compilation_output": "The output of the compilation action.",
        "compiler_flags": "List of compiler flags.",
        "imports": "A depset of import paths.",
        "interface_srcs": "A depset of interface source files, transitive sources included.",
        "linker_flags": "List of linker flags, passed directly to the linker.",
        "linking_context": "A rules_cc LinkingContext (essentially a depset of needed libraries, including transitive ones).",
        "source_only": "If true, the source files are compiled, but no library is produced.",
        "string_imports": "A depset of string import paths.",
        "versions": "A depset of version identifiers.",
    },
    init = _dinfo_init,
)
