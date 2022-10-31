# Copyright (C) 2022 Toitware ApS. All rights reserved.
# Use of this source code is governed by an MIT-style license that can be
# found in the LICENSE file.

PROTOC_GEN_TOIT_PATH := protoc-gen-toit/protoc-gen-toit

PROTO_FLAGS ?=

CORE_PROTO_SOURCE_DIR := /usr/include
CORE_PROTO_OUT_DIR := src/protogen
CORE_PROTO_SOURCES := $(shell find $(CORE_PROTO_SOURCE_DIR)/google -name '*.proto')
CORE_PROTO_FILES := $(CORE_PROTO_SOURCES:$(CORE_PROTO_SOURCE_DIR)/%.proto=$(CORE_PROTO_OUT_DIR)/%_pb.toit)
CORE_PROTO_FLAGS := --proto_path $(CORE_PROTO_SOURCE_DIR) -I$(CORE_PROTO_SOURCE_DIR)/google $(PROTO_FLAGS)

all: protoc-gen-toit protobuf

install-pkgs: rebuild-cmake
	(cd build && ninja install-pkgs)

test: install-pkgs rebuild-cmake protoc-gen-toit
	(cd build && ninja check)
	$(MAKE) -C protoc-gen-toit test

protoc-gen-toit:
	make -C $(dir $(PROTOC_GEN_TOIT_PATH)) protoc-gen-toit

protobuf: $(CORE_PROTO_FILES)
	$(MAKE) -C ./tests protobuf
	$(MAKE) -C ./examples/core_objects protobuf
	$(MAKE) -C ./examples/helloworld protobuf
	$(MAKE) -C ./examples/imports protobuf
	$(MAKE) -C ./examples/nesting protobuf
	$(MAKE) -C ./examples/oneofs protobuf

src/protogen/google/%_pb.toit: $(CORE_PROTO_SOURCE_DIR)/google/%.proto $(CORE_PROTO_OUT_DIR)
	protoc $< --plugin=protoc-gen-toit=$(PROTOC_GEN_TOIT_PATH) \
			--toit_out=$(CORE_PROTO_OUT_DIR) \
			"--toit_opt=constructor_initializers=1;toit_protobuf_library=../protobuf.toit" \
			$(CORE_PROTO_FLAGS)

$(CORE_PROTO_OUT_DIR):
	mkdir -p $@

# We rebuild the cmake file all the time.
# We use "glob" in the cmakefile, and wouldn't otherwise notice if a new
# file (for example a test) was added or removed.
# It takes <1s on Linux to run cmake, so it doesn't hurt to run it frequently.
rebuild-cmake:
	mkdir -p build
	(cd build && cmake .. -G Ninja)

clean:
	$(MAKE) -C ./examples/core_objects clean
	$(MAKE) -C ./examples/helloworld clean
	$(MAKE) -C ./examples/imports clean
	$(MAKE) -C ./examples/nesting clean
	$(MAKE) -C ./examples/oneofs clean
	rm -rf $(CORE_PROTO_OUT_DIR)
	rm -rf build

.PHONY: all test rebuild-cmake install-pkgs protoc-gen-toit protobuf clean
