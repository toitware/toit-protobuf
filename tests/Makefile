# Copyright (C) 2022 Toitware ApS.
# Use of this source code is governed by a Zero-Clause BSD license that can
# be found in the TESTS_LICENSE file.

PROTO_FLAGS ?=
PROTOC_GEN_TOIT_PATH := ../protoc-gen-toit/protoc-gen-toit
PROTO_SOURCE_DIR := .
PROTO_OUT_DIR := .

PROTO_SOURCES := $(shell find $(PROTO_SOURCE_DIR) -name '*.proto')
PROTO_TARGETS := $(PROTO_SOURCES:$(PROTO_SOURCE_DIR)/%.proto=$(PROTO_OUT_DIR)/%_pb.toit)

.PHONY: all
all: protobuf python-golds test

.PHONY: test
test: protobuf
	(cd ../build && ninja check)

.PHONY: protobuf
protobuf: $(PROTO_TARGETS)

$(PROTO_OUT_DIR)/%_pb.toit: $(PROTO_SOURCE_DIR)/%.proto $(PROTO_OUT_DIR) $(PROTOC_GEN_TOIT_PATH)
	protoc --plugin=protoc-gen-toit=$(PROTOC_GEN_TOIT_PATH) $< --toit_out=$(PROTO_OUT_DIR) --toit_opt=constructor_initializers=1 $(PROTO_FLAGS)

$(PROTO_OUT_DIR):
	mkdir -p $(PROTO_OUT_DIR)

$(PROTOC_GEN_TOIT_PATH):
	make -C $(dir $(PROTOC_GEN_TOIT_PATH)) protoc-gen-toit

.PHONY: python-golds
python-golds: all_types_test.proto
	protoc $< --python_out=. $(PROTO_FLAGS)
	python all_types_test-gold_generator.py --create-required gold/all_types_test-required.gold
	python all_types_test-gold_generator.py --create-all gold/all_types_test-all.gold

clean:
	rm -f $(PROTO_OUT_DIR)/*_pb.toit
	rm -f gold/*.gold
