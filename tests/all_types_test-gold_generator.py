import sys

import all_types_test_pb2


def test_required_only():
  msg = all_types_test_pb2.TestAllTypes()
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
  msg.required_bool = True
  msg.required_string = "foo"
  msg.required_bytes = b"bar"
  msg.required_nested_message.field = 7017
  msg.required_nested_enum = all_types_test_pb2.TestAllTypes.FOO
  msg.required_string_piece = "gee"
  msg.required_cord = "cord!"

  return msg.SerializeToString()

def test_all():
  msg = all_types_test_pb2.TestAllTypes()

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
  msg.required_bool = True
  msg.required_string = "foo"
  msg.required_bytes = b"bar"
  msg.required_nested_message.field = 7017
  msg.required_nested_enum = all_types_test_pb2.TestAllTypes.FOO
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
  msg.optional_bool = False
  msg.optional_bool = True
  msg.optional_string = "barO"
  msg.optional_bytes = b"fooO"
  msg.optional_nested_message.field = 70180
  msg.optional_nested_enum = all_types_test_pb2.TestAllTypes.BAR
  msg.optional_string_piece = "geeO"
  msg.optional_cord = "cordO!"
  msg.oneof_uint32 = 111

  msg.repeated_int32.append(0)
  msg.repeated_int32.append(11)
  msg.repeated_int32.append(22)
  msg.repeated_int64.append(33)
  msg.repeated_int64.append(44)
  msg.repeated_uint32.append(111)
  msg.repeated_uint32.append(222)
  msg.repeated_uint64.append(333)
  msg.repeated_uint64.append(444)
  msg.repeated_sint32.append(-111)
  msg.repeated_sint32.append(-222)
  msg.repeated_sint64.append(-333)
  msg.repeated_sint64.append(-444)
  msg.repeated_fixed32.append(111)
  msg.repeated_fixed32.append(222)
  msg.repeated_fixed64.append(333)
  msg.repeated_fixed64.append(444)
  msg.repeated_sfixed32.append(-111)
  msg.repeated_sfixed32.append(-222)
  msg.repeated_sfixed64.append(-333)
  msg.repeated_sfixed64.append(-444)
  msg.repeated_float.append(1.5)
  msg.repeated_float.append(2.5)
  msg.repeated_double.append(1.25)
  msg.repeated_double.append(2.25)
  msg.repeated_bool.append(True)
  msg.repeated_bool.append(False)
  msg.repeated_string.append("foo")
  msg.repeated_string.append("bar")
  msg.repeated_bytes.append(b"bar")
  msg.repeated_bytes.append(b"foo")
  msg.repeated_nested_message.add().field = 7017
  msg.repeated_nested_message.add().field = 7018
  msg.repeated_nested_enum.append(all_types_test_pb2.TestAllTypes.GEE)
  msg.repeated_nested_enum.append(all_types_test_pb2.TestAllTypes.BAR)
  msg.repeated_string_piece.append("gee")
  msg.repeated_string_piece.append("gee2")
  msg.repeated_cord.append("cord!")
  msg.repeated_cord.append("cord2!")

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
  msg.default_bool = True
  msg.default_string = "default"
  msg.default_bytes = b"bytes"
  msg.default_nested_enum = all_types_test_pb2.TestAllTypes.BAR
  msg.default_string_piece = "default"
  msg.default_cord = "cord!"

  return msg.SerializeToString()

if __name__ == "__main__":
  if sys.argv[1] == "--create-required":
    bytes = test_required_only()
  elif sys.argv[1] == "--create-all":
    bytes = test_all()
  else:
    print("Unknown argument: %s" % sys.argv[1])
    sys.exit(1)

  with open(sys.argv[2], 'wb') as f:
    f.write(bytes)

