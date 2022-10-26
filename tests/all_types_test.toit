// Copyright (C) 2022 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the tests/TESTS_LICENSE file.

import bytes
import host.file
import protobuf
import expect show *

import .all_types_test_pb

main:
  test_required
  test_all

test_required:
  gold := file.read_content "tests/gold/all_types_test-required.gold"

  msg := TestAllTypes
  msg.required_int32 = 1
  msg.required_int64 = 2
  msg.required_uint32 = 1000000
  msg.required_uint64 = 1000000000000
  msg.required_sint32 = -1000000
  msg.required_sint64 = -1000000000000
  msg.required_fixed32 = 1000000
  msg.required_fixed64 = 1000000000000
  msg.required_sfixed32 = -1000000
  msg.required_sfixed64 = -1000000000000
  msg.required_float = 1.5
  msg.required_double = 1.25
  msg.required_bool = true
  msg.required_string = "foo"
  msg.required_bytes = #['b', 'a', 'r']
  msg.required_nested_message.field = 7017
  msg.required_nested_enum = TestAllTypes_NestedEnum_FOO
  msg.required_string_piece = "gee"
  msg.required_cord = "cord!"

  buffer := bytes.Buffer
  writer := protobuf.Writer buffer
  msg.serialize writer
  result := buffer.bytes

  expect_equals gold result

  reader := protobuf.Reader result
  deserialized := TestAllTypes.deserialize reader

  expect_equals 1 deserialized.required_int32
  expect_equals 2 deserialized.required_int64
  expect_equals 1000000 deserialized.required_uint32
  expect_equals 1000000000000 deserialized.required_uint64
  expect_equals -1000000 deserialized.required_sint32
  expect_equals -1000000000000 deserialized.required_sint64
  expect_equals 1000000 deserialized.required_fixed32
  expect_equals 1000000000000 deserialized.required_fixed64
  expect_equals -1000000 deserialized.required_sfixed32
  expect_equals -1000000000000 deserialized.required_sfixed64
  expect_equals 1.5 deserialized.required_float
  expect_equals 1.25 deserialized.required_double
  expect deserialized.required_bool
  expect_equals "foo" deserialized.required_string
  expect_equals #['b', 'a', 'r'] deserialized.required_bytes
  expect_equals 7017 deserialized.required_nested_message.field
  expect_equals TestAllTypes_NestedEnum_FOO deserialized.required_nested_enum
  expect_equals "gee" deserialized.required_string_piece
  expect_equals "cord!" deserialized.required_cord

  expect_equals 0 deserialized.optional_int32
  expect_equals 0 deserialized.optional_int64
  expect_equals 0 deserialized.optional_uint32
  expect_equals 0 deserialized.optional_uint64
  expect_equals 0 deserialized.optional_sint32
  expect_equals 0 deserialized.optional_sint64
  expect_equals 0 deserialized.optional_fixed32
  expect_equals 0 deserialized.optional_fixed64
  expect_equals 0 deserialized.optional_sfixed32
  expect_equals 0 deserialized.optional_sfixed64
  expect_equals 0.0 deserialized.optional_float
  expect_equals 0.0 deserialized.optional_double
  expect_not deserialized.optional_bool
  expect_equals "" deserialized.optional_string
  expect_equals #[] deserialized.optional_bytes
  expect_equals 0 deserialized.optional_nested_message.field
  expect_equals 0 deserialized.optional_nested_enum
  expect_equals "" deserialized.optional_string_piece
  expect_equals "" deserialized.optional_cord

  expect_equals 0 deserialized.repeated_int32.size
  expect_equals 0 deserialized.repeated_int64.size
  expect_equals 0 deserialized.repeated_uint32.size
  expect_equals 0 deserialized.repeated_uint64.size
  expect_equals 0 deserialized.repeated_sint32.size
  expect_equals 0 deserialized.repeated_sint64.size
  expect_equals 0 deserialized.repeated_fixed32.size
  expect_equals 0 deserialized.repeated_fixed64.size
  expect_equals 0 deserialized.repeated_sfixed32.size
  expect_equals 0 deserialized.repeated_sfixed64.size
  expect_equals 0 deserialized.repeated_float.size
  expect_equals 0 deserialized.repeated_double.size
  expect_equals 0 deserialized.repeated_bool.size
  expect_equals 0 deserialized.repeated_string.size
  expect_equals 0 deserialized.repeated_bytes.size
  expect_equals 0 deserialized.repeated_nested_message.size
  expect_equals 0 deserialized.repeated_nested_enum.size
  expect_equals 0 deserialized.repeated_string_piece.size
  expect_equals 0 deserialized.repeated_cord.size

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

test_all:
  gold := file.read_content "tests/gold/all_types_test-all.gold"

  msg := TestAllTypes

  msg.required_int32 = 1
  msg.required_int64 = 2
  msg.required_uint32 = 1000000
  msg.required_uint64 = 1000000000000
  msg.required_sint32 = -1000000
  msg.required_sint64 = -1000000000000
  msg.required_fixed32 = 1000000
  msg.required_fixed64 = 1000000000000
  msg.required_sfixed32 = -1000000
  msg.required_sfixed64 = -1000000000000
  msg.required_float = 1.5
  msg.required_double = 1.25
  msg.required_bool = true
  msg.required_string = "foo"
  msg.required_bytes = "bar".to_byte_array
  msg.required_nested_message.field = 7017
  msg.required_nested_enum = TestAllTypes_NestedEnum_FOO
  msg.required_string_piece = "gee"
  msg.required_cord = "cord!"

  msg.optional_int32 = -1
  msg.optional_int64 = -2
  msg.optional_uint32 = 2000000
  msg.optional_uint64 = 2000000000000
  msg.optional_sint32 = -2000000
  msg.optional_sint64 = -2000000000000
  msg.optional_fixed32 = 2000000
  msg.optional_fixed64 = 2000000000000
  msg.optional_sfixed32 = -2000000
  msg.optional_sfixed64 = -2000000000000
  msg.optional_float = 2.5
  msg.optional_double = 2.25
  // Toit doesn't encode optional values if they would be the default value.
  // Therefore only test non-default values for optional fields.
  // msg.optional_bool = false
  msg.optional_bool = true
  msg.optional_string = "barO"
  msg.optional_bytes = "fooO".to_byte_array
  msg.optional_nested_message.field = 70180
  msg.optional_nested_enum = TestAllTypes_NestedEnum_BAR
  msg.optional_string_piece = "geeO"
  msg.optional_cord = "cordO!"
  msg.oneof_field_oneof_uint32 = 111

  // Test a default value in a repeated field.
  msg.repeated_int32.add 0
  msg.repeated_int32.add 11
  msg.repeated_int32.add 22
  msg.repeated_int64.add 33
  msg.repeated_int64.add 44
  msg.repeated_uint32.add 111
  msg.repeated_uint32.add 222
  msg.repeated_uint64.add 333
  msg.repeated_uint64.add 444
  msg.repeated_sint32.add -111
  msg.repeated_sint32.add -222
  msg.repeated_sint64.add -333
  msg.repeated_sint64.add -444
  msg.repeated_fixed32.add 111
  msg.repeated_fixed32.add 222
  msg.repeated_fixed64.add 333
  msg.repeated_fixed64.add 444
  msg.repeated_sfixed32.add -111
  msg.repeated_sfixed32.add -222
  msg.repeated_sfixed64.add -333
  msg.repeated_sfixed64.add -444
  msg.repeated_float.add 1.5
  msg.repeated_float.add 2.5
  msg.repeated_double.add 1.25
  msg.repeated_double.add 2.25
  msg.repeated_bool.add true
  msg.repeated_bool.add false
  msg.repeated_string.add "foo"
  msg.repeated_string.add "bar"
  msg.repeated_bytes.add "bar".to_byte_array
  msg.repeated_bytes.add "foo".to_byte_array
  nested := TestAllTypes_NestedMessage
  nested.field = 7017
  msg.repeated_nested_message.add nested
  nested2 := TestAllTypes_NestedMessage
  nested2.field = 7018
  msg.repeated_nested_message.add nested2
  msg.repeated_nested_enum.add TestAllTypes_NestedEnum_GEE
  msg.repeated_nested_enum.add TestAllTypes_NestedEnum_BAR
  msg.repeated_string_piece.add "gee"
  msg.repeated_string_piece.add "gee2"
  msg.repeated_cord.add "cord!"
  msg.repeated_cord.add "cord2!"

  msg.default_int32 = 101
  msg.default_int64 = 102
  msg.default_uint32 = 1000100
  msg.default_uint64 = 1000100000000
  msg.default_sint32 = -1000100
  msg.default_sint64 = -1000100000000
  msg.default_fixed32 = 1000100
  msg.default_fixed64 = 1000100000000
  msg.default_sfixed32 = -1000100
  msg.default_sfixed64 = -1000100000000
  msg.default_float = 1.125
  msg.default_double = 1.025
  msg.default_bool = true
  msg.default_string = "default"
  msg.default_bytes = "bytes".to_byte_array
  msg.default_nested_enum = TestAllTypes_NestedEnum_BAR
  msg.default_string_piece = "default"
  msg.default_cord = "cord!"

  buffer := bytes.Buffer
  writer := protobuf.Writer buffer
  msg.serialize writer
  encoded := buffer.bytes

  expect_equals gold encoded

  reader := protobuf.Reader encoded
  deserialized := TestAllTypes.deserialize reader

  expect_equals 1 deserialized.required_int32
  expect_equals 2 deserialized.required_int64
  expect_equals 1000000 deserialized.required_uint32
  expect_equals 1000000000000 deserialized.required_uint64
  expect_equals -1000000 deserialized.required_sint32
  expect_equals -1000000000000 deserialized.required_sint64
  expect_equals 1000000 deserialized.required_fixed32
  expect_equals 1000000000000 deserialized.required_fixed64
  expect_equals -1000000 deserialized.required_sfixed32
  expect_equals -1000000000000 deserialized.required_sfixed64
  expect_equals 1.5 deserialized.required_float
  expect_equals 1.25 deserialized.required_double
  expect deserialized.required_bool
  expect_equals "foo" deserialized.required_string
  expect_equals #['b', 'a', 'r'] deserialized.required_bytes
  expect_equals 7017 deserialized.required_nested_message.field
  expect_equals TestAllTypes_NestedEnum_FOO deserialized.required_nested_enum
  expect_equals "gee" deserialized.required_string_piece
  expect_equals "cord!" deserialized.required_cord

  msg.optional_int32 = -1
  msg.optional_int64 = -2
  msg.optional_uint32 = 2000000
  msg.optional_uint64 = 2000000000000
  msg.optional_sint32 = -2000000
  msg.optional_sint64 = -2000000000000
  msg.optional_fixed32 = 2000000
  msg.optional_fixed64 = 2000000000000
  msg.optional_sfixed32 = -2000000
  msg.optional_sfixed64 = -2000000000000
  msg.optional_float = 2.5
  msg.optional_double = 2.25
  msg.optional_bool = true
  msg.optional_string = "barO"
  msg.optional_bytes = "fooO".to_byte_array
  msg.optional_nested_message.field = 70180
  msg.optional_nested_enum = TestAllTypes_NestedEnum_BAR
  msg.optional_string_piece = "geeO"
  msg.optional_cord = "cordO!"
  msg.oneof_field_oneof_uint32 = 111

  expect_equals 3 deserialized.repeated_int32.size
  expect_equals 0 deserialized.repeated_int32[0]
  expect_equals 11 deserialized.repeated_int32[1]
  expect_equals 22 deserialized.repeated_int32[2]
  expect_equals 2 deserialized.repeated_int64.size
  expect_equals 33 deserialized.repeated_int64[0]
  expect_equals 44 deserialized.repeated_int64[1]
  expect_equals 2 deserialized.repeated_uint32.size
  expect_equals 111 deserialized.repeated_uint32[0]
  expect_equals 222 deserialized.repeated_uint32[1]
  expect_equals 2 deserialized.repeated_uint64.size
  expect_equals 333 deserialized.repeated_uint64[0]
  expect_equals 444 deserialized.repeated_uint64[1]
  expect_equals 2 deserialized.repeated_sint32.size
  expect_equals -111 deserialized.repeated_sint32[0]
  expect_equals -222 deserialized.repeated_sint32[1]
  expect_equals 2 deserialized.repeated_sint64.size
  expect_equals -333 deserialized.repeated_sint64[0]
  expect_equals -444 deserialized.repeated_sint64[1]
  expect_equals 2 deserialized.repeated_fixed32.size
  expect_equals 111 deserialized.repeated_fixed32[0]
  expect_equals 222 deserialized.repeated_fixed32[1]
  expect_equals 2 deserialized.repeated_fixed64.size
  expect_equals 333 deserialized.repeated_fixed64[0]
  expect_equals 444 deserialized.repeated_fixed64[1]
  expect_equals 2 deserialized.repeated_sfixed32.size
  expect_equals -111 deserialized.repeated_sfixed32[0]
  expect_equals -222 deserialized.repeated_sfixed32[1]
  expect_equals 2 deserialized.repeated_sfixed64.size
  expect_equals -333 deserialized.repeated_sfixed64[0]
  expect_equals -444 deserialized.repeated_sfixed64[1]
  expect_equals 2 deserialized.repeated_float.size
  expect_equals 1.5 deserialized.repeated_float[0]
  expect_equals 2.5 deserialized.repeated_float[1]
  expect_equals 2 deserialized.repeated_double.size
  expect_equals 1.25 deserialized.repeated_double[0]
  expect_equals 2.25 deserialized.repeated_double[1]
  expect_equals 2 deserialized.repeated_bool.size
  expect deserialized.repeated_bool[0]
  expect_not deserialized.repeated_bool[1]
  expect_equals 2 deserialized.repeated_string.size
  expect_equals "foo" deserialized.repeated_string[0]
  expect_equals "bar" deserialized.repeated_string[1]
  expect_equals 2 deserialized.repeated_bytes.size
  expect_equals #['b', 'a', 'r'] deserialized.repeated_bytes[0]
  expect_equals #['f', 'o', 'o'] deserialized.repeated_bytes[1]
  expect_equals 2 deserialized.repeated_nested_enum.size
  expect_equals TestAllTypes_NestedEnum_GEE deserialized.repeated_nested_enum[0]
  expect_equals TestAllTypes_NestedEnum_BAR deserialized.repeated_nested_enum[1]
  expect_equals 2 deserialized.repeated_string_piece.size
  expect_equals "gee" deserialized.repeated_string_piece[0]
  expect_equals "gee2" deserialized.repeated_string_piece[1]
  expect_equals 2 deserialized.repeated_cord.size
  expect_equals "cord!" deserialized.repeated_cord[0]
  expect_equals "cord2!" deserialized.repeated_cord[1]

  expect_equals 101 deserialized.default_int32
  expect_equals 102 deserialized.default_int64
  expect_equals 1000100 deserialized.default_uint32
  expect_equals 1000100000000 deserialized.default_uint64
  expect_equals -1000100 deserialized.default_sint32
  expect_equals -1000100000000 deserialized.default_sint64
  expect_equals 1000100 deserialized.default_fixed32
  expect_equals 1000100000000 deserialized.default_fixed64
  expect_equals -1000100 deserialized.default_sfixed32
  expect_equals -1000100000000 deserialized.default_sfixed64
  expect_equals 1.125 deserialized.default_float
  expect_equals 1.025 deserialized.default_double
  expect deserialized.default_bool
  expect_equals "default" deserialized.default_string
  expect_equals #['b', 'y', 't', 'e', 's'] deserialized.default_bytes
  expect_equals TestAllTypes_NestedEnum_BAR deserialized.default_nested_enum
  expect_equals "default" deserialized.default_string_piece
  expect_equals "cord!" deserialized.default_cord
