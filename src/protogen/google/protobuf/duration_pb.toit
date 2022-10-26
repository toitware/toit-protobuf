// Code generated by protoc-gen-toit. DO NOT EDIT.
// source: google/protobuf/duration.proto

import protobuf as _protobuf
import core as _core

// MESSAGE START: .google.protobuf.Duration
class Duration extends _protobuf.Message:
  seconds/int := 0
  nanos/int := 0

  constructor
      --seconds/int?=null
      --nanos/int?=null:
    if seconds != null:
      this.seconds = seconds
    if nanos != null:
      this.nanos = nanos

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        seconds = r.read_primitive _protobuf.PROTOBUF_TYPE_INT64
      r.read_field 2:
        nanos = r.read_primitive _protobuf.PROTOBUF_TYPE_INT32

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_INT64 seconds --as_field=1
    w.write_primitive _protobuf.PROTOBUF_TYPE_INT32 nanos --as_field=2

  num_fields_set -> int:
    return (seconds == 0 ? 0 : 1)
      + (nanos == 0 ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_INT64 seconds --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_INT32 nanos --as_field=2)

// MESSAGE END: .google.protobuf.Duration

