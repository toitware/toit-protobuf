# Protobuf

A Toit package for working with protobuf.

## Generation
The protoc-gen-toit folder contains the protoc plugin for generating Toit code from
protobuf files.

The plugin is written in Go and can be installed using
`go install github.com/toitware/toit-protobuf/protoc-gen-toit@latest`.
See [protoc-gen-toit/README.md](protoc-gen-toit/README.md) for more information.

You still need the protoc compiler to generate code from the protobuf files.

A sample invocation looks like this:

``` bash
PROTOBUF_FILE=tests/all_types_test.proto
OUT_DIR=/tmp/out_dir
protoc $PROTOBUF_FILE --toit_out=$OUT_DIR
```

The [Makefile](Makefile) and [test Makefile](tests/Makefile) also contain examples
to generate code from the protobuf files.

Specifically, you might need the Google core types, which have the following
Makefile rule:

``` Makefile
PROTOC_GEN_TOIT_PATH := protoc-gen-toit/protoc-gen-toit

PROTO_FLAGS ?=

CORE_PROTO_SOURCE_DIR := /usr/include
CORE_PROTO_OUT_DIR := src/protogen
CORE_PROTO_SOURCES := $(shell find $(CORE_PROTO_SOURCE_DIR)/google -name '*.proto')
CORE_PROTO_FILES := $(CORE_PROTO_SOURCES:$(CORE_PROTO_SOURCE_DIR)/%.proto=$(CORE_PROTO_OUT_DIR)/%_pb.toit)
CORE_PROTO_FLAGS := --proto_path $(CORE_PROTO_SOURCE_DIR) -I$(CORE_PROTO_SOURCE_DIR)/google $(PROTO_FLAGS)

src/protogen/google/%_pb.toit: $(CORE_PROTO_SOURCE_DIR)/google/%.proto $(CORE_PROTO_OUT_DIR)
	protoc $< --plugin=protoc-gen-toit=$(PROTOC_GEN_TOIT_PATH) \
			--toit_out=$(CORE_PROTO_OUT_DIR) \
			"--toit_opt=constructor_initializers=1;toit_protobuf_library=../protobuf.toit" \
			$(CORE_PROTO_FLAGS)
```

More information on how to generate code can be found in
[protoc-gen-toit/README.md](protoc-gen-toit/README.md).

## Usage
The generated Toit code requires this protobuf package. As such, one needs to add this package as a
dependency to any project that uses the generated files.
