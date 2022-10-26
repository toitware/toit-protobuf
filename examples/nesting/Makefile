# Copyright (C) 2022 Toitware ApS.
# Use of this source code is governed by a Zero-Clause BSD license that can
# be found in the EXAMPLES_LICENSE file.

PROTO_FLAGS ?=

.PHONY: protoc-gen-toit
protoc-gen-toit:
	make -C ../../ protoc-gen-toit

protobuf: protoc-gen-toit
	protoc --plugin=protoc-gen-toit=../../protoc-gen-toit nesting.proto --toit_out=. --toit_opt=constructor_initializers=1 $(PROTO_FLAGS)

clean:
	rm -f *_pb.toit
