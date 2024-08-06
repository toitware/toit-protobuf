// Copyright (C) 2020 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import .varint as varint
import bytes as old-bytes
import io
import io show LITTLE-ENDIAN

// 0 is reserved for errors.
PROTOBUF-TYPE-DOUBLE    ::= 1
PROTOBUF-TYPE-FLOAT     ::= 2
PROTOBUF-TYPE-BOOL      ::= 3

PROTOBUF-TYPE-INT64     ::= 4
PROTOBUF-TYPE-INT32     ::= 5
PROTOBUF-TYPE-SINT64    ::= 6
PROTOBUF-TYPE-SINT32    ::= 7
PROTOBUF-TYPE-SFIXED64  ::= 8
PROTOBUF-TYPE-SFIXED32  ::= 9

PROTOBUF-TYPE-UINT64    ::= 10
PROTOBUF-TYPE-UINT32    ::= 11
PROTOBUF-TYPE-FIXED64   ::= 12
PROTOBUF-TYPE-FIXED32   ::= 13
PROTOBUF-TYPE-ENUM      ::= 14

PROTOBUF-TYPE-STRING    ::= 15
PROTOBUF-TYPE-BYTES     ::= 16

PROTOBUF-TYPE-GROUP     ::= 17
PROTOBUF-TYPE-MESSAGE   ::= 18

interface Reader:
  read-primitive type/int -> any
  read-array value-type/int array/List [construct-value] -> List
  read-map map/Map [construct-key] [construct-value] -> Map
  read-message [construct-message] -> none
  read-field field-pos/int [construct-field] -> none
  reset -> none

  constructor in/ByteArray:
    return Reader_ in

interface Writer:
  write-primitive type/int value/any --as-field/int?=null --oneof/bool=false --in-array/bool=false -> int
  write-array value-type/int array/List --as-field/int?=null --oneof/bool=false [serialize-value] -> int
  write-map key-type/int value-type/int map/Map --as-field/int?=null --oneof/bool=false [serialize-key] [serialize-value] -> none
  write-message-header msg/Message --as-field/int?=null --oneof/bool=false -> none
  reset -> none

  /**
  Builds a $Writer from the given $io.Buffer or $old-bytes.Buffer.
  Support for $old-bytes.Buffer is deprecated and will be removed in the future.
  */
  constructor out:
    if out is not io.Writer:
      // TODO(florian): when removing this error and the old-bytes.Buffer support,
      //   also type the field in the 'Writer_' class.
      print-on-stderr_ "Support for bytes.buffer is deprecated. Use io.Buffer instead."
    return Writer_ out

abstract class Message:
  abstract serialize writer/Writer --as-field/int?=null --oneof/bool=false -> none

  abstract num-fields-set -> int

  /// Returns the byte size used to encode the message in protobuf.
  abstract protobuf-size -> int

  is-empty -> bool:
    return num-fields-set == 0

/// Decodes a google.protobuf.Duration message into a $Duration.
deserialize-duration r/Reader -> Duration:
  result := Duration.ZERO
  seconds := 0
  nanos := 0
  r.read-message:
    r.read-field 1:
      seconds = r.read-primitive PROTOBUF-TYPE-INT64
    r.read-field 2:
      nanos = r.read-primitive PROTOBUF-TYPE-INT32
    result = Duration --s=seconds --ns=nanos
  return result

class FakeMessage_ extends Message:
  num-fields-set/int := ?
  protobuf-size/int := ?

  constructor .num-fields-set .protobuf-size:

  serialize writer/Writer --as-field/int?=null --oneof/bool=false -> none:

  with num-fields-set/int protobuf-size/int -> Message:
    this.num-fields-set = num-fields-set
    this.protobuf-size = protobuf-size
    return this

// We can reuse the fakeMessage_ since write_message_header will not do any recursing calls.
fakeMessage_ := FakeMessage_ 0 0

/// Encodes a $Duration into a google.protobuf.Duration message.
serialize-duration d/Duration w/Writer --as-field/int?=null --oneof/bool=false:
  seconds := d.in-s
  nanos := d.in-ns % Duration.NANOSECONDS-PER-SECOND
  num-fields-set :=
    (seconds == 0 ? 0 : 1) +
      (nanos == 0 ? 0 : 1)
  w.write-message-header (fakeMessage_.with num-fields-set (size-duration d)) --as-field=as-field --oneof=oneof
  if seconds != 0:
    w.write-primitive PROTOBUF-TYPE-INT64 seconds --as-field=1
  if nanos != 0:
    w.write-primitive PROTOBUF-TYPE-INT32 nanos --as-field=2

size-duration d/Duration --as-field/int?=null -> int:
  seconds := d.in-s
  nanos := d.in-ns % Duration.NANOSECONDS-PER-SECOND
  msg-size := (size-primitive PROTOBUF-TYPE-INT64 seconds --as-field=1)
    + (size-primitive PROTOBUF-TYPE-INT32 nanos --as-field=2)
  return size-embedded-message msg-size --as-field=as-field

/// Decodes a google.protobuf.Timestamp message into a $Time.
deserialize-timestamp r/Reader -> Time:
  result := TIME-ZERO-EPOCH
  seconds := 0
  nanos := 0
  r.read-message:
    r.read-field 1:
      seconds = r.read-primitive PROTOBUF-TYPE-INT64
    r.read-field 2:
      nanos = r.read-primitive PROTOBUF-TYPE-INT32
    result = Time.epoch --s=seconds --ns=nanos
  return result

/// Encodes a $Time into a google.protobuf.Timestamp message.
serialize-timestamp t/Time w/Writer --as-field/int?=null --oneof/bool=false -> none:
  seconds := t.s-since-epoch
  nanos := t.ns-part
  num-fields-set :=
    (seconds == 0 ? 0 : 1) +
      (nanos == 0 ? 0 : 1)
  w.write-message-header (fakeMessage_.with num-fields-set (size-timestamp t)) --as-field=as-field --oneof=oneof
  if seconds != 0:
    w.write-primitive PROTOBUF-TYPE-INT64 seconds --as-field=1
  if nanos != 0:
    w.write-primitive PROTOBUF-TYPE-INT32 nanos --as-field=2

size-timestamp t/Time --as-field/int?=null -> int:
  seconds := t.s-since-epoch
  nanos := t.ns-part
  msg-size := (size-primitive PROTOBUF-TYPE-INT64 seconds --as-field=1)
    + (size-primitive PROTOBUF-TYPE-INT32 nanos --as-field=2)
  return size-embedded-message msg-size --as-field=as-field

time-is-zero-epoch t/Time -> bool:
  return t.ns-part == 0 and t.s-since-epoch == 0

TIME-ZERO-EPOCH/Time ::= Time.epoch

ERR-UNSUPPORTED-TYPE ::= "UNSUPPORTED_TYPE"
ERR-INVALID-TYPE ::= "INVALID_TYPE"
ERR-UNSUPPORTED-WIRE-TYPE ::= "UNSUPPORTED_WIRE_TYPE"

PROTOBUF-WIRE-TYPE-VARINT         ::= 0
PROTOBUF-WIRE-TYPE-64BIT          ::= 1
PROTOBUF-WIRE-TYPE-LEN-DELIMITED  ::= 2
PROTOBUF-WIRE-TYPE-START-GROUP    ::= 3
PROTOBUF-WIRE-TYPE-END-GROUP      ::= 4
PROTOBUF-WIRE-TYPE-32BIT          ::= 5

class Reader_ implements Reader:
  bytes_/ByteArray ::= ?

  read-offset_/int := 0
  msg-end/int? := null
  current-wire-type/int? := null

  constructor .bytes_:

  reset -> none:
    read-offset_ = 0
    msg-end = null

  read-varint_ -> int:
    i := varint.decode bytes_ read-offset_
    skip-varint_ i
    return i

  peek-varint_ -> int:
    i := varint.decode bytes_ read-offset_
    return i

  skip-varint_ i/int:
    read-offset_ += varint.size i

  skip-varint_:
    read-offset_ += varint.byte-size --offset=read-offset_ bytes_

  read-primitive protobuf-type/int -> any:
    if protobuf-type == PROTOBUF-TYPE-DOUBLE:
      result := LITTLE-ENDIAN.float64 bytes_ read-offset_
      read-offset_ += 8
      return result
    else if protobuf-type == PROTOBUF-TYPE-FLOAT:
      result := LITTLE-ENDIAN.float32 bytes_ read-offset_
      read-offset_ += 4
      return result
    else if PROTOBUF-TYPE-INT64 <= protobuf-type <= PROTOBUF-TYPE-INT32 or
            PROTOBUF-TYPE-UINT64 <= protobuf-type <= PROTOBUF-TYPE-UINT32:
      return read-varint_
    else if PROTOBUF-TYPE-SINT64 <= protobuf-type <= PROTOBUF-TYPE-SINT32:
      result := read-varint_
      return (result >> 1) ^ -(result & 1)
    else if protobuf-type == PROTOBUF-TYPE-FIXED32 or protobuf-type == PROTOBUF-TYPE-SFIXED32:
      result := LITTLE-ENDIAN.int32 bytes_ read-offset_
      read-offset_ += 4
      return result
    else if protobuf-type == PROTOBUF-TYPE-FIXED64 or protobuf-type == PROTOBUF-TYPE-SFIXED64:
      result := LITTLE-ENDIAN.int64 bytes_ read-offset_
      read-offset_ += 8
      return result
    else if protobuf-type == PROTOBUF-TYPE-ENUM:
      return read-varint_
    else if protobuf-type == PROTOBUF-TYPE-BOOL:
      return read-varint_ != 0
    else if protobuf-type == PROTOBUF-TYPE-STRING:
      size := read-varint_
      result := bytes_.to-string read-offset_ read-offset_+size
      read-offset_ += size
      return result
    else if protobuf-type == PROTOBUF-TYPE-BYTES:
      size := read-varint_
      result := bytes_.copy read-offset_ read-offset_+size
      read-offset_ += size
      return result
    throw ERR-INVALID-TYPE

  read-array value-type/int array/List  [construct-value] -> List:
    prev-msg-end := msg-end
    is-packed := current-wire-type == PROTOBUF-WIRE-TYPE-LEN-DELIMITED and value-type < PROTOBUF-TYPE-STRING
    if is-packed:
      size := read-varint_
      msg-end = size + read-offset_
      while read-offset_ < msg-end:
        array.add construct-value.call
    else:
      array.add construct-value.call
    msg-end = prev-msg-end
    return array

  read-map map/Map [construct-key] [construct-value] -> Map:
    prev-msg-end := msg-end
    msg-end = read-varint_ + read-offset_
    while read-offset_ < msg-end:
      key := null
      read-field 1:
        key = construct-key.call
      read-field 2:
        value := construct-value.call
        if key != null:
          map[key] = value
    msg-end = prev-msg-end

    return map

  read-message [construct-message]:
    prev-msg-end := msg-end
    msg-end = prev-msg-end == null ? bytes_.size : read-varint_ + read-offset_

    while read-offset_ < msg-end:
      current-offset := read-offset_
      construct-message.call

      if current-offset == read-offset_:
        key := read-varint_
        wire-type := key & 0b111
        skip-element wire-type

    msg-end = prev-msg-end

  skip-element wire-type/int:
    if wire-type == PROTOBUF-WIRE-TYPE-VARINT:
      skip-varint_
    else if wire-type == PROTOBUF-TYPE-INT64:
      read-offset_ += 8
    else if wire-type == PROTOBUF-WIRE-TYPE-LEN-DELIMITED:
      read-offset_ += read-varint_
    else if wire-type == PROTOBUF-WIRE-TYPE-32BIT:
      read-offset_ + 4
    else:
      throw ERR-UNSUPPORTED-WIRE-TYPE

  read-field field-pos/int [construct-field]:
    if msg-end <= read-offset_:
      return
    key := peek-varint_
    wire-type := key & 0b111
    field := key >> 3
    if field-pos != field:
      return

    // skip the wire_type and field_pos.
    read-varint_

    prev-wire-type := current-wire-type
    current-wire-type = wire-type

    construct-field.call wire-type

    current-wire-type = prev-wire-type


class Writer_ implements Writer:
  // We reuse the buffer across writers. This works because serialization
  // cannot yield.
  static VARINT-BUFFER_/ByteArray := ByteArray 10

  // TODO(florian): change this to io.Buffer type.
  out_/any

  collection-field/int? := null
  writing-map/bool := false

  constructor .out_:

  reset:
    writing-map = false
    collection-field = null
    out_.clear

  buffer_ -> ByteArray:
    if out_ is io.Buffer:
      return (out_ as io.Buffer).backing-array
    else:
      return (out_ as old-bytes.Buffer).buffer

  write-key_ type/int as-field/int -> int:
    return write-varint_
      (as-field << 3) | type

  offset-reserved_ size:
    offset := out_.size
    if out_ is io.Buffer:
      (out_ as io.Buffer).grow-by size
    else:
      (out_ as old-bytes.Buffer).grow size
    return offset

  write-primitive protobuf-type/int value/any --oneof/bool=false --as-field/int?=null --in-array/bool=false -> none:
    as-field = as-field or collection-field
    can-skip := not oneof and as-field and not in-array
    if protobuf-type == PROTOBUF-TYPE-DOUBLE:
      if can-skip and value == 0.0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-64BIT as-field
      offset := offset-reserved_ 8
      LITTLE-ENDIAN.put-float64 buffer_ offset value
    else if protobuf-type == PROTOBUF-TYPE-FLOAT:
      if can-skip and value == 0.0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-32BIT as-field
      offset := offset-reserved_ 4
      LITTLE-ENDIAN.put-float32 buffer_ offset value
    else if PROTOBUF-TYPE-INT64 <= protobuf-type <= PROTOBUF-TYPE-INT32 or
            PROTOBUF-TYPE-UINT64 <= protobuf-type <= PROTOBUF-TYPE-UINT32:
      if can-skip and value == 0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-VARINT as-field
      write-varint_ value
    else if PROTOBUF-TYPE-SINT64 <= protobuf-type <= PROTOBUF-TYPE-SINT32:
      if can-skip and value == 0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-VARINT as-field
      write-varint_ (value >> 63) ^ (value << 1)
    else if protobuf-type == PROTOBUF-TYPE-FIXED32 or protobuf-type == PROTOBUF-TYPE-SFIXED32:
      if can-skip and value == 0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-32BIT as-field
      offset := offset-reserved_ 4
      LITTLE-ENDIAN.put-int32 buffer_ offset value
    else if protobuf-type == PROTOBUF-TYPE-FIXED64 or protobuf-type == PROTOBUF-TYPE-SFIXED64:
      if can-skip and value == 0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-64BIT as-field
      offset := offset-reserved_ 8
      LITTLE-ENDIAN.put-int64 buffer_ offset value
    else if protobuf-type == PROTOBUF-TYPE-ENUM:
      if as-field != null and value == 0:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-VARINT as-field
      write-varint_ value
    else if protobuf-type == PROTOBUF-TYPE-BOOL:
      if can-skip and not value:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-VARINT as-field
      write-varint_ (value ? 1 : 0)
    else if protobuf-type == PROTOBUF-TYPE-STRING:
      if can-skip and value == "":
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-LEN-DELIMITED as-field
      write-varint_ value.size
      out_.write value
    else if protobuf-type == PROTOBUF-TYPE-BYTES:
      if can-skip and value.is-empty:
        return
      if as-field != null:
        write-key_ PROTOBUF-WIRE-TYPE-LEN-DELIMITED as-field
      write-varint_ value.size
      out_.write value
    else:
      throw ERR-UNSUPPORTED-TYPE

  write-array protobuf-value-type/int array/List --oneof/bool=false --as-field/int?=null [serialize-value] -> none:
    if as-field == null:
      as-field = collection-field

    should-pack := protobuf-value-type < PROTOBUF-TYPE-STRING
    size := 0

    if should-pack:
      size = size-array protobuf-value-type array

    if not oneof and as-field != null and array.is-empty:
      return

    curr-collection-field := collection-field
    if should-pack:
      // We have to null the collection field in this scenario, we want children
      // to be written as without the --as_field flag set and we might have an map element ancestor.
      collection-field = null
    else:
      collection-field = as-field

    if should-pack:
      write-key_ PROTOBUF-WIRE-TYPE-LEN-DELIMITED as-field
      write-varint_ size

    array.do serialize-value

    collection-field = curr-collection-field

  write-map protobuf-key-type/int protobuf-value-type/int map/Map --oneof/bool=false --as-field/int?=null [serialize-key] [serialize-value] -> none:
    if as-field == null:
      as-field = collection-field
    if not oneof and as-field != null and map.is-empty:
      return

    curr-collection-field := collection-field

    map.do: | k v |
      kv-size := protobuf-key-type == PROTOBUF-TYPE-MESSAGE ?
        size-embedded-message k.protobuf-size --as-field=1 :
        size-primitive protobuf-key-type k --as-field=1
      kv-size += protobuf-value-type == PROTOBUF-TYPE-MESSAGE ?
        size-embedded-message v.protobuf-size --as-field=2 :
        size-primitive protobuf-key-type v --as-field=2
      this.write-message-header (fakeMessage_.with 2 kv-size) --as-field=as-field
      collection-field = 1
      serialize-key.call k
      collection-field = 2
      serialize-value.call v

    collection-field = curr-collection-field

  write-message-header msg/Message --oneof/bool=false --as-field/int?=null -> none:
    if as-field == null:
      as-field = collection-field

    // We don't have to null the collection_field in this scenario.
    // All children of a message serialization will be with an --as_field set.

    // If this is the first object we don't need a header.
    if as-field == null:
      return

    size := msg.protobuf-size
    if size == 0:
      return
    write-key_ PROTOBUF-WIRE-TYPE-LEN-DELIMITED as-field
    write-varint_ size

  write-varint_ i/int -> int:
    size := varint.encode VARINT-BUFFER_ 0 i
    return out_.write VARINT-BUFFER_ 0 size

size-key_ field/int -> int:
  return varint.size (field << 3)

size-array protobuf-value-type/int array/List --as-field/int?=null -> int:
  if array.is-empty:
    return 0
  size := 0

  should-pack := protobuf-value-type < PROTOBUF-TYPE-STRING

  array.do:
    if should-pack:
      // Note we can never pack a type message
      size += size-primitive protobuf-value-type it --in-array
    else:
      size += protobuf-value-type == PROTOBUF-TYPE-MESSAGE ?
        size-embedded-message it.protobuf-size --as-field=as-field :
        size-primitive protobuf-value-type it --as-field=as-field --in-array

  if should-pack:
    return size-embedded-message size --as-field=as-field
  return size

size-map protobuf-key-type/int protobuf-value-type/int map/Map --as-field/int?=null  -> int:
  size := 0
  map.do: | k v |
    kv-size := protobuf-key-type == PROTOBUF-TYPE-MESSAGE ?
      size-embedded-message k.protobuf-size --as-field=1 :
      size-primitive protobuf-key-type k --as-field=1
    kv-size += protobuf-value-type == PROTOBUF-TYPE-MESSAGE ?
      size-embedded-message v.protobuf-size --as-field=2 :
      size-primitive protobuf-value-type v --as-field=2
    size += size-embedded-message kv-size  --as-field=as-field
  return size

size-embedded-message msg-size/int --as-field/int?=null -> int:
  if msg-size == 0:
    return 0
  if as-field == null:
    return msg-size
  return (size-key_ as-field) + (varint.size msg-size) + msg-size

size-primitive protobuf-type/int value/any --as-field/int?=null --in-array/bool=false -> int:
  header-size := as-field != null ? (size-key_ as-field) : 0
  if protobuf-type == PROTOBUF-TYPE-DOUBLE:
    if value == 0.0 and not in-array:
      return 0
    return header-size + 8
  else if protobuf-type == PROTOBUF-TYPE-FLOAT:
    if value == 0.0 and not in-array:
      return 0
    return header-size + 4
  else if PROTOBUF-TYPE-INT64 <= protobuf-type <= PROTOBUF-TYPE-INT32 or
          PROTOBUF-TYPE-UINT64 <= protobuf-type <= PROTOBUF-TYPE-UINT32:
    if value == 0 and not in-array:
      return 0
    return header-size + (varint.size value)
  else if PROTOBUF-TYPE-SINT64 <= protobuf-type <= PROTOBUF-TYPE-SINT32:
    if value == 0 and not in-array:
      return 0
    return header-size + (varint.size ((value >> 63) ^ (value << 1)))
  else if protobuf-type == PROTOBUF-TYPE-FIXED32 or protobuf-type == PROTOBUF-TYPE-SFIXED32:
    if value == 0 and not in-array:
      return 0
    return header-size + 4
  else if protobuf-type == PROTOBUF-TYPE-FIXED64 or protobuf-type == PROTOBUF-TYPE-SFIXED64:
    if value == 0 and not in-array:
      return 0
    return header-size + 8
  else if protobuf-type == PROTOBUF-TYPE-ENUM:
    if value == 0 and not in-array:
      return 0
    return header-size + (varint.size value)
  else if protobuf-type == PROTOBUF-TYPE-BOOL:
    if not value and not in-array:
      return 0
    return header-size + 1
  else if protobuf-type == PROTOBUF-TYPE-STRING:
    if value == "" and not in-array:
      return 0
    return header-size + (varint.size value.size) + value.size
  else if protobuf-type == PROTOBUF-TYPE-BYTES:
    if value.is-empty and not in-array:
      return 0
    return header-size + (varint.size value.size) + value.size
  else:
    throw ERR-UNSUPPORTED-TYPE
