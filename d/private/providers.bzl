"""Module containing definitions of D providers."""

def _dinfo_init(
        *,
        compile_flags = None,
        imports = None,
        interface_srcs = None,
        libraries = None,
        linker_flags = None,
        source_only = False,
        string_imports = None,
        versions = None):
    """Initializes the DInfo provider."""
    return {
        "compile_flags": compile_flags or [],
        "imports": imports or depset(),
        "interface_srcs": interface_srcs or depset(),
        "libraries": libraries or depset(),
        "linker_flags": linker_flags or [],
        "source_only": source_only,
        "string_imports": string_imports or depset(),
        "versions": versions or depset(),
    }

DInfo, _new_dinfo = provider(
    doc = "Provider containing D compilation information",
    fields = {
        "compile_flags": "List of compiler flags.",
        "imports": "A depset of import paths.",
        "interface_srcs": "A depset of interface source files, transitive sources included.",
        "libraries": "A depset of libraries, transitive libraries too.",
        "linker_flags": "List of linker flags, passed directly to the linker.",
        "source_only": "If true, the source files are compiled, but no library is produced.",
        "string_imports": "A depset of string import paths.",
        "versions": "A depset of version identifiers.",
    },
    init = _dinfo_init,
)
