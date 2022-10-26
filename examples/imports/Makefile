# Copyright (C) 2022 Toitware ApS.
# Use of this source code is governed by a Zero-Clause BSD license that can
# be found in the EXAMPLES_LICENSE file.

PROTO_DIR := ./pkg
PROTO_SOURCES := $(shell find . -name '*.proto')
PROTO_TARGETS := $(PROTO_SOURCES:$(PROTO_DIR)/%.proto=toit/%_pb.toit)
PROTO_FLAGS ?=

targets:
	# $(PROTO_TARGETS)

toit:
	mkdir toit

.PHONY: protoc-gen-toit
protoc-gen-toit:
	make -C ../../ protoc-gen-toit

toit/%_pb.toit: $(PROTO_DIR)/%.proto toit
	protoc --plugin=protoc-gen-toit=../../protoc-gen-toit  $< --toit_out=toit --toit_opt=import_library=pkg=. $(PROTO_FLAGS)

protobuf: $(PROTO_TARGETS) protoc-gen-toit

clean:
	rm -rf toit
