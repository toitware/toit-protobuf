# Protobuf

A Toit package for working with protobuf.

The tool folder contains the protoc plugin for generating toit code from protobuf files. The plugin
is written in Go and can be installed using `go install github.com/toitware/toit-protobuf/tool@latest`.
See [tool/README.md](tool/README.md) for more information.

The generated Toit code requires this protobuf package. As such, one needs to add this package as a
dependency to any project that uses the generated files.
