"Public API of D rules."

load("//d/private/rules:binary.bzl", _d_binary = "d_binary")
load("//d/private/rules:library.bzl", _d_library = "d_library")
load("//d/private/rules:proto.bzl", _d_proto_library = "d_proto_library")
load("//d/private/rules:test.bzl", _d_test = "d_test")

d_binary = _d_binary
d_library = _d_library
d_proto_library = _d_proto_library
d_test = _d_test
