// Code generated by protoc-gen-toit. DO NOT EDIT.
// source: google/protobuf/field_mask.proto

import ....protobuf as _protobuf
import core as _core

// MESSAGE START: .google.protobuf.FieldMask
class FieldMask extends _protobuf.Message:
  paths/List/*<string>*/ := []

  constructor
      --paths/List?/*<string>*/=null:
    if paths != null:
      this.paths = paths

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        paths = r.read_array _protobuf.PROTOBUF_TYPE_STRING paths:
          r.read_primitive _protobuf.PROTOBUF_TYPE_STRING

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_array _protobuf.PROTOBUF_TYPE_STRING paths --as_field=1: | value/string | 
      w.write_primitive _protobuf.PROTOBUF_TYPE_STRING value --in_array

  num_fields_set -> int:
    return (paths.is_empty ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_array _protobuf.PROTOBUF_TYPE_STRING paths --as_field=1)

// MESSAGE END: .google.protobuf.FieldMask

