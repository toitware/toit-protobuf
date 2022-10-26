# Copyright (C) 2022 Toitware ApS.
# Use of this source code is governed by a Zero-Clause BSD license that can
# be found in the TESTS_LICENSE file.

PROTOC_GEN_TOIT := ../tool/protoc-gen-toit
PROTO_FLAGS ?=

.PHONY: all
all: protogen python-golds

.PHONY: protogen
protogen: all_types_test.proto $(PROTOC_GEN_TOIT)
	protoc --plugin=protoc-gen-toit=$(PROTOC_GEN_TOIT) $< --toit_out=. --toit_opt=constructor_initializers=1 $(PROTO_FLAGS)

.PHONY: python-golds
python-golds: all_types_test.proto
	protoc $< --python_out=. $(PROTO_FLAGS)
	python all_types_test-gold_generator.py --create-required gold/all_types_test-required.gold
	python all_types_test-gold_generator.py --create-all gold/all_types_test-all.gold

$(PROTOC_GEN_TOIT):
	$(MAKE) -C ../tool protoc-gen-toit
