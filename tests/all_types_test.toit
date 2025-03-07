// Copyright (C) 2022 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/TESTS_LICENSE file.

import host.file
import io
import protobuf
import expect show *

import .all-types-test-pb

main:
  test-required
  test-all

test-required:
  gold := file.read-contents "tests/gold/all_types_test-required.gold"

  msg := TestAllTypes
  msg.required-int32 = 1
  msg.required-int64 = 2
  msg.required-uint32 = 1000000
  msg.required-uint64 = 1000000000000
  msg.required-sint32 = -1000000
  msg.required-sint64 = -1000000000000
  msg.required-fixed32 = 1000000
  msg.required-fixed64 = 1000000000000
  msg.required-sfixed32 = -1000000
  msg.required-sfixed64 = -1000000000000
  msg.required-float = 1.5
  msg.required-double = 1.25
  msg.required-bool = true
  msg.required-string = "foo"
  msg.required-bytes = #['b', 'a', 'r']
  msg.required-nested-message.field = 7017
  msg.required-nested-enum = TestAllTypes-NestedEnum-FOO
  msg.required-string-piece = "gee"
  msg.required-cord = "cord!"

  buffer := io.Buffer
  writer := protobuf.Writer buffer
  msg.serialize writer
  result := buffer.bytes

  expect-equals gold result

  reader := protobuf.Reader result
  deserialized := TestAllTypes.deserialize reader

  expect-equals 1 deserialized.required-int32
  expect-equals 2 deserialized.required-int64
  expect-equals 1000000 deserialized.required-uint32
  expect-equals 1000000000000 deserialized.required-uint64
  expect-equals -1000000 deserialized.required-sint32
  expect-equals -1000000000000 deserialized.required-sint64
  expect-equals 1000000 deserialized.required-fixed32
  expect-equals 1000000000000 deserialized.required-fixed64
  expect-equals -1000000 deserialized.required-sfixed32
  expect-equals -1000000000000 deserialized.required-sfixed64
  expect-equals 1.5 deserialized.required-float
  expect-equals 1.25 deserialized.required-double
  expect deserialized.required-bool
  expect-equals "foo" deserialized.required-string
  expect-equals #['b', 'a', 'r'] deserialized.required-bytes
  expect-equals 7017 deserialized.required-nested-message.field
  expect-equals TestAllTypes-NestedEnum-FOO deserialized.required-nested-enum
  expect-equals "gee" deserialized.required-string-piece
  expect-equals "cord!" deserialized.required-cord

  expect-equals 0 deserialized.optional-int32
  expect-equals 0 deserialized.optional-int64
  expect-equals 0 deserialized.optional-uint32
  expect-equals 0 deserialized.optional-uint64
  expect-equals 0 deserialized.optional-sint32
  expect-equals 0 deserialized.optional-sint64
  expect-equals 0 deserialized.optional-fixed32
  expect-equals 0 deserialized.optional-fixed64
  expect-equals 0 deserialized.optional-sfixed32
  expect-equals 0 deserialized.optional-sfixed64
  expect-equals 0.0 deserialized.optional-float
  expect-equals 0.0 deserialized.optional-double
  expect-not deserialized.optional-bool
  expect-equals "" deserialized.optional-string
  expect-equals #[] deserialized.optional-bytes
  expect-equals 0 deserialized.optional-nested-message.field
  expect-equals 0 deserialized.optional-nested-enum
  expect-equals "" deserialized.optional-string-piece
  expect-equals "" deserialized.optional-cord

  expect-equals 0 deserialized.repeated-int32.size
  expect-equals 0 deserialized.repeated-int64.size
  expect-equals 0 deserialized.repeated-uint32.size
  expect-equals 0 deserialized.repeated-uint64.size
  expect-equals 0 deserialized.repeated-sint32.size
  expect-equals 0 deserialized.repeated-sint64.size
  expect-equals 0 deserialized.repeated-fixed32.size
  expect-equals 0 deserialized.repeated-fixed64.size
  expect-equals 0 deserialized.repeated-sfixed32.size
  expect-equals 0 deserialized.repeated-sfixed64.size
  expect-equals 0 deserialized.repeated-float.size
  expect-equals 0 deserialized.repeated-double.size
  expect-equals 0 deserialized.repeated-bool.size
  expect-equals 0 deserialized.repeated-string.size
  expect-equals 0 deserialized.repeated-bytes.size
  expect-equals 0 deserialized.repeated-nested-message.size
  expect-equals 0 deserialized.repeated-nested-enum.size
  expect-equals 0 deserialized.repeated-string-piece.size
  expect-equals 0 deserialized.repeated-cord.size

  // TODO(florian): default values don't seem to work.
  // expect_equals 61 deserialized.default_int32
  // expect_equals 62 deserialized.default_int64
  // expect_equals 63 deserialized.default_uint32
  // expect_equals 64 deserialized.default_uint64
  // expect_equals -65 deserialized.default_sint32
  // expect_equals -66 deserialized.default_sint64
  // expect_equals 67 deserialized.default_fixed32
  // expect_equals 68 deserialized.default_fixed64
  // expect_equals -69 deserialized.default_sfixed32
  // expect_equals -70 deserialized.default_sfixed64
  // expect_equals 71.1 deserialized.default_float
  // expect_equals 72.2 deserialized.default_double
  // expect deserialized.default_bool
  // expect_equals "string_default" deserialized.default_string
  // expect_equals "byte-default".to_byte_array deserialized.default_bytes
  // expect_equals TestAllTypes_NestedEnum_BAR deserialized.default_nested_enum
  // expect_equals "foo" deserialized.default_string_piece
  // expect_equals "bar" deserialized.default_cord

test-all:
  gold := file.read-contents "tests/gold/all_types_test-all.gold"

  msg := TestAllTypes

  msg.required-int32 = 1
  msg.required-int64 = 2
  msg.required-uint32 = 1000000
  msg.required-uint64 = 1000000000000
  msg.required-sint32 = -1000000
  msg.required-sint64 = -1000000000000
  msg.required-fixed32 = 1000000
  msg.required-fixed64 = 1000000000000
  msg.required-sfixed32 = -1000000
  msg.required-sfixed64 = -1000000000000
  msg.required-float = 1.5
  msg.required-double = 1.25
  msg.required-bool = true
  msg.required-string = "foo"
  msg.required-bytes = "bar".to-byte-array
  msg.required-nested-message.field = 7017
  msg.required-nested-enum = TestAllTypes-NestedEnum-FOO
  msg.required-string-piece = "gee"
  msg.required-cord = "cord!"

  msg.optional-int32 = -1
  msg.optional-int64 = -2
  msg.optional-uint32 = 2000000
  msg.optional-uint64 = 2000000000000
  msg.optional-sint32 = -2000000
  msg.optional-sint64 = -2000000000000
  msg.optional-fixed32 = 2000000
  msg.optional-fixed64 = 2000000000000
  msg.optional-sfixed32 = -2000000
  msg.optional-sfixed64 = -2000000000000
  msg.optional-float = 2.5
  msg.optional-double = 2.25
  // Toit doesn't encode optional values if they would be the default value.
  // Therefore only test non-default values for optional fields.
  // msg.optional_bool = false
  msg.optional-bool = true
  msg.optional-string = "barO"
  msg.optional-bytes = "fooO".to-byte-array
  msg.optional-nested-message.field = 70180
  msg.optional-nested-enum = TestAllTypes-NestedEnum-BAR
  msg.optional-string-piece = "geeO"
  msg.optional-cord = "cordO!"
  msg.oneof-field-oneof-uint32 = 111

  // Test a default value in a repeated field.
  msg.repeated-int32.add 0
  msg.repeated-int32.add 11
  msg.repeated-int32.add 22
  msg.repeated-int64.add 33
  msg.repeated-int64.add 44
  msg.repeated-uint32.add 111
  msg.repeated-uint32.add 222
  msg.repeated-uint64.add 333
  msg.repeated-uint64.add 444
  msg.repeated-sint32.add -111
  msg.repeated-sint32.add -222
  msg.repeated-sint64.add -333
  msg.repeated-sint64.add -444
  msg.repeated-fixed32.add 111
  msg.repeated-fixed32.add 222
  msg.repeated-fixed64.add 333
  msg.repeated-fixed64.add 444
  msg.repeated-sfixed32.add -111
  msg.repeated-sfixed32.add -222
  msg.repeated-sfixed64.add -333
  msg.repeated-sfixed64.add -444
  msg.repeated-float.add 1.5
  msg.repeated-float.add 2.5
  msg.repeated-double.add 1.25
  msg.repeated-double.add 2.25
  msg.repeated-bool.add true
  msg.repeated-bool.add false
  msg.repeated-string.add "foo"
  msg.repeated-string.add "bar"
  msg.repeated-bytes.add "bar".to-byte-array
  msg.repeated-bytes.add "foo".to-byte-array
  nested := TestAllTypes-NestedMessage
  nested.field = 7017
  msg.repeated-nested-message.add nested
  nested2 := TestAllTypes-NestedMessage
  nested2.field = 7018
  msg.repeated-nested-message.add nested2
  msg.repeated-nested-enum.add TestAllTypes-NestedEnum-GEE
  msg.repeated-nested-enum.add TestAllTypes-NestedEnum-BAR
  msg.repeated-string-piece.add "gee"
  msg.repeated-string-piece.add "gee2"
  msg.repeated-cord.add "cord!"
  msg.repeated-cord.add "cord2!"

  msg.default-int32 = 101
  msg.default-int64 = 102
  msg.default-uint32 = 1000100
  msg.default-uint64 = 1000100000000
  msg.default-sint32 = -1000100
  msg.default-sint64 = -1000100000000
  msg.default-fixed32 = 1000100
  msg.default-fixed64 = 1000100000000
  msg.default-sfixed32 = -1000100
  msg.default-sfixed64 = -1000100000000
  msg.default-float = 1.125
  msg.default-double = 1.025
  msg.default-bool = true
  msg.default-string = "default"
  msg.default-bytes = "bytes".to-byte-array
  msg.default-nested-enum = TestAllTypes-NestedEnum-BAR
  msg.default-string-piece = "default"
  msg.default-cord = "cord!"

  buffer := io.Buffer
  writer := protobuf.Writer buffer
  msg.serialize writer
  encoded := buffer.bytes

  expect-equals gold encoded

  reader := protobuf.Reader encoded
  deserialized := TestAllTypes.deserialize reader

  expect-equals 1 deserialized.required-int32
  expect-equals 2 deserialized.required-int64
  expect-equals 1000000 deserialized.required-uint32
  expect-equals 1000000000000 deserialized.required-uint64
  expect-equals -1000000 deserialized.required-sint32
  expect-equals -1000000000000 deserialized.required-sint64
  expect-equals 1000000 deserialized.required-fixed32
  expect-equals 1000000000000 deserialized.required-fixed64
  expect-equals -1000000 deserialized.required-sfixed32
  expect-equals -1000000000000 deserialized.required-sfixed64
  expect-equals 1.5 deserialized.required-float
  expect-equals 1.25 deserialized.required-double
  expect deserialized.required-bool
  expect-equals "foo" deserialized.required-string
  expect-equals #['b', 'a', 'r'] deserialized.required-bytes
  expect-equals 7017 deserialized.required-nested-message.field
  expect-equals TestAllTypes-NestedEnum-FOO deserialized.required-nested-enum
  expect-equals "gee" deserialized.required-string-piece
  expect-equals "cord!" deserialized.required-cord

  msg.optional-int32 = -1
  msg.optional-int64 = -2
  msg.optional-uint32 = 2000000
  msg.optional-uint64 = 2000000000000
  msg.optional-sint32 = -2000000
  msg.optional-sint64 = -2000000000000
  msg.optional-fixed32 = 2000000
  msg.optional-fixed64 = 2000000000000
  msg.optional-sfixed32 = -2000000
  msg.optional-sfixed64 = -2000000000000
  msg.optional-float = 2.5
  msg.optional-double = 2.25
  msg.optional-bool = true
  msg.optional-string = "barO"
  msg.optional-bytes = "fooO".to-byte-array
  msg.optional-nested-message.field = 70180
  msg.optional-nested-enum = TestAllTypes-NestedEnum-BAR
  msg.optional-string-piece = "geeO"
  msg.optional-cord = "cordO!"
  msg.oneof-field-oneof-uint32 = 111

  expect-equals 3 deserialized.repeated-int32.size
  expect-equals 0 deserialized.repeated-int32[0]
  expect-equals 11 deserialized.repeated-int32[1]
  expect-equals 22 deserialized.repeated-int32[2]
  expect-equals 2 deserialized.repeated-int64.size
  expect-equals 33 deserialized.repeated-int64[0]
  expect-equals 44 deserialized.repeated-int64[1]
  expect-equals 2 deserialized.repeated-uint32.size
  expect-equals 111 deserialized.repeated-uint32[0]
  expect-equals 222 deserialized.repeated-uint32[1]
  expect-equals 2 deserialized.repeated-uint64.size
  expect-equals 333 deserialized.repeated-uint64[0]
  expect-equals 444 deserialized.repeated-uint64[1]
  expect-equals 2 deserialized.repeated-sint32.size
  expect-equals -111 deserialized.repeated-sint32[0]
  expect-equals -222 deserialized.repeated-sint32[1]
  expect-equals 2 deserialized.repeated-sint64.size
  expect-equals -333 deserialized.repeated-sint64[0]
  expect-equals -444 deserialized.repeated-sint64[1]
  expect-equals 2 deserialized.repeated-fixed32.size
  expect-equals 111 deserialized.repeated-fixed32[0]
  expect-equals 222 deserialized.repeated-fixed32[1]
  expect-equals 2 deserialized.repeated-fixed64.size
  expect-equals 333 deserialized.repeated-fixed64[0]
  expect-equals 444 deserialized.repeated-fixed64[1]
  expect-equals 2 deserialized.repeated-sfixed32.size
  expect-equals -111 deserialized.repeated-sfixed32[0]
  expect-equals -222 deserialized.repeated-sfixed32[1]
  expect-equals 2 deserialized.repeated-sfixed64.size
  expect-equals -333 deserialized.repeated-sfixed64[0]
  expect-equals -444 deserialized.repeated-sfixed64[1]
  expect-equals 2 deserialized.repeated-float.size
  expect-equals 1.5 deserialized.repeated-float[0]
  expect-equals 2.5 deserialized.repeated-float[1]
  expect-equals 2 deserialized.repeated-double.size
  expect-equals 1.25 deserialized.repeated-double[0]
  expect-equals 2.25 deserialized.repeated-double[1]
  expect-equals 2 deserialized.repeated-bool.size
  expect deserialized.repeated-bool[0]
  expect-not deserialized.repeated-bool[1]
  expect-equals 2 deserialized.repeated-string.size
  expect-equals "foo" deserialized.repeated-string[0]
  expect-equals "bar" deserialized.repeated-string[1]
  expect-equals 2 deserialized.repeated-bytes.size
  expect-equals #['b', 'a', 'r'] deserialized.repeated-bytes[0]
  expect-equals #['f', 'o', 'o'] deserialized.repeated-bytes[1]
  expect-equals 2 deserialized.repeated-nested-enum.size
  expect-equals TestAllTypes-NestedEnum-GEE deserialized.repeated-nested-enum[0]
  expect-equals TestAllTypes-NestedEnum-BAR deserialized.repeated-nested-enum[1]
  expect-equals 2 deserialized.repeated-string-piece.size
  expect-equals "gee" deserialized.repeated-string-piece[0]
  expect-equals "gee2" deserialized.repeated-string-piece[1]
  expect-equals 2 deserialized.repeated-cord.size
  expect-equals "cord!" deserialized.repeated-cord[0]
  expect-equals "cord2!" deserialized.repeated-cord[1]

  expect-equals 101 deserialized.default-int32
  expect-equals 102 deserialized.default-int64
  expect-equals 1000100 deserialized.default-uint32
  expect-equals 1000100000000 deserialized.default-uint64
  expect-equals -1000100 deserialized.default-sint32
  expect-equals -1000100000000 deserialized.default-sint64
  expect-equals 1000100 deserialized.default-fixed32
  expect-equals 1000100000000 deserialized.default-fixed64
  expect-equals -1000100 deserialized.default-sfixed32
  expect-equals -1000100000000 deserialized.default-sfixed64
  expect-equals 1.125 deserialized.default-float
  expect-equals 1.025 deserialized.default-double
  expect deserialized.default-bool
  expect-equals "default" deserialized.default-string
  expect-equals #['b', 'y', 't', 'e', 's'] deserialized.default-bytes
  expect-equals TestAllTypes-NestedEnum-BAR deserialized.default-nested-enum
  expect-equals "default" deserialized.default-string-piece
  expect-equals "cord!" deserialized.default-cord
