// Code generated by protoc-gen-toit. DO NOT EDIT.
// source: google/protobuf/struct.proto

import ....protobuf as _protobuf
import core as _core

// ENUM START: NullValue
NullValue-NULL-VALUE/int/*enum<NullValue>*/ ::= 0
// ENUM END: .google.protobuf.NullValue

// MESSAGE START: .google.protobuf.Struct
class Struct extends _protobuf.Message:
  fields/Map/*<string,Value>*/ := {:}

  constructor
      --fields/Map?/*<string,Value>*/=null:
    if fields != null:
      this.fields = fields

  constructor.deserialize r/_protobuf.Reader:
    r.read-message:
      r.read-field 1:
        fields = r.read-map fields
          :
            r.read-primitive _protobuf.PROTOBUF-TYPE-STRING
          :
            Value.deserialize r

  serialize w/_protobuf.Writer --as-field/int?=null --oneof/bool=false -> none:
    w.write-message-header this --as-field=as-field --oneof=oneof
    w.write-map _protobuf.PROTOBUF-TYPE-STRING _protobuf.PROTOBUF-TYPE-MESSAGE fields --as-field=1
      : | key/string | 
        w.write-primitive _protobuf.PROTOBUF-TYPE-STRING key
      : | value/Value | 
        value.serialize w

  num-fields-set -> int:
    return (fields.is-empty ? 0 : 1)

  protobuf-size -> int:
    return (_protobuf.size-map _protobuf.PROTOBUF-TYPE-STRING _protobuf.PROTOBUF-TYPE-MESSAGE fields --as-field=1)

// MESSAGE END: .google.protobuf.Struct

// MESSAGE START: .google.protobuf.Value
class Value extends _protobuf.Message:
  // ONEOF START: .google.protobuf.Value.kind
  kind_ := null
  kind-oneof-case_/int? := null

  kind-oneof-clear -> none:
    kind_ = null
    kind-oneof-case_ = null

  static KIND-NULL-VALUE/int ::= 1
  static KIND-NUMBER-VALUE/int ::= 2
  static KIND-STRING-VALUE/int ::= 3
  static KIND-BOOL-VALUE/int ::= 4
  static KIND-STRUCT-VALUE/int ::= 5
  static KIND-LIST-VALUE/int ::= 6

  kind-oneof-case -> int?:
    return kind-oneof-case_

  kind-null-value -> int/*enum<NullValue>*/:
    return kind_

  kind-null-value= kind/int/*enum<NullValue>*/ -> none:
    kind_ = kind
    kind-oneof-case_ = KIND-NULL-VALUE

  kind-number-value -> float:
    return kind_

  kind-number-value= kind/float -> none:
    kind_ = kind
    kind-oneof-case_ = KIND-NUMBER-VALUE

  kind-string-value -> string:
    return kind_

  kind-string-value= kind/string -> none:
    kind_ = kind
    kind-oneof-case_ = KIND-STRING-VALUE

  kind-bool-value -> bool:
    return kind_

  kind-bool-value= kind/bool -> none:
    kind_ = kind
    kind-oneof-case_ = KIND-BOOL-VALUE

  kind-struct-value -> Struct:
    return kind_

  kind-struct-value= kind/Struct -> none:
    kind_ = kind
    kind-oneof-case_ = KIND-STRUCT-VALUE

  kind-list-value -> ListValue:
    return kind_

  kind-list-value= kind/ListValue -> none:
    kind_ = kind
    kind-oneof-case_ = KIND-LIST-VALUE

  // ONEOF END: .google.protobuf.Value.kind

  constructor
      --kind-null-value/int?/*enum<NullValue>?*/=null
      --kind-number-value/float?=null
      --kind-string-value/string?=null
      --kind-bool-value/bool?=null
      --kind-struct-value/Struct?=null
      --kind-list-value/ListValue?=null:
    if kind-null-value != null:
      this.kind-null-value = kind-null-value
    if kind-number-value != null:
      this.kind-number-value = kind-number-value
    if kind-string-value != null:
      this.kind-string-value = kind-string-value
    if kind-bool-value != null:
      this.kind-bool-value = kind-bool-value
    if kind-struct-value != null:
      this.kind-struct-value = kind-struct-value
    if kind-list-value != null:
      this.kind-list-value = kind-list-value

  constructor.deserialize r/_protobuf.Reader:
    r.read-message:
      r.read-field 1:
        kind-null-value = r.read-primitive _protobuf.PROTOBUF-TYPE-ENUM
      r.read-field 2:
        kind-number-value = r.read-primitive _protobuf.PROTOBUF-TYPE-DOUBLE
      r.read-field 3:
        kind-string-value = r.read-primitive _protobuf.PROTOBUF-TYPE-STRING
      r.read-field 4:
        kind-bool-value = r.read-primitive _protobuf.PROTOBUF-TYPE-BOOL
      r.read-field 5:
        kind-struct-value = Struct.deserialize r
      r.read-field 6:
        kind-list-value = ListValue.deserialize r

  serialize w/_protobuf.Writer --as-field/int?=null --oneof/bool=false -> none:
    w.write-message-header this --as-field=as-field --oneof=oneof
    if kind-oneof-case_ == KIND-NULL-VALUE:
      w.write-primitive _protobuf.PROTOBUF-TYPE-ENUM kind_ --as-field=KIND-NULL-VALUE --oneof
    if kind-oneof-case_ == KIND-NUMBER-VALUE:
      w.write-primitive _protobuf.PROTOBUF-TYPE-DOUBLE kind_ --as-field=KIND-NUMBER-VALUE --oneof
    if kind-oneof-case_ == KIND-STRING-VALUE:
      w.write-primitive _protobuf.PROTOBUF-TYPE-STRING kind_ --as-field=KIND-STRING-VALUE --oneof
    if kind-oneof-case_ == KIND-BOOL-VALUE:
      w.write-primitive _protobuf.PROTOBUF-TYPE-BOOL kind_ --as-field=KIND-BOOL-VALUE --oneof
    if kind-oneof-case_ == KIND-STRUCT-VALUE:
      kind_.serialize w --as-field=KIND-STRUCT-VALUE --oneof
    if kind-oneof-case_ == KIND-LIST-VALUE:
      kind_.serialize w --as-field=KIND-LIST-VALUE --oneof

  num-fields-set -> int:
    return (kind-oneof-case_ == null ? 0 : 1)

  protobuf-size -> int:
    return (kind-oneof-case_ == KIND-NULL-VALUE ? (_protobuf.size-primitive _protobuf.PROTOBUF-TYPE-ENUM kind-null-value --as-field=1) : 0)
      + (kind-oneof-case_ == KIND-NUMBER-VALUE ? (_protobuf.size-primitive _protobuf.PROTOBUF-TYPE-DOUBLE kind-number-value --as-field=2) : 0)
      + (kind-oneof-case_ == KIND-STRING-VALUE ? (_protobuf.size-primitive _protobuf.PROTOBUF-TYPE-STRING kind-string-value --as-field=3) : 0)
      + (kind-oneof-case_ == KIND-BOOL-VALUE ? (_protobuf.size-primitive _protobuf.PROTOBUF-TYPE-BOOL kind-bool-value --as-field=4) : 0)
      + (kind-oneof-case_ == KIND-STRUCT-VALUE ? (_protobuf.size-embedded-message (kind-struct-value.protobuf-size) --as-field=5) : 0)
      + (kind-oneof-case_ == KIND-LIST-VALUE ? (_protobuf.size-embedded-message (kind-list-value.protobuf-size) --as-field=6) : 0)

// MESSAGE END: .google.protobuf.Value

// MESSAGE START: .google.protobuf.ListValue
class ListValue extends _protobuf.Message:
  values/List/*<Value>*/ := []

  constructor
      --values/List?/*<Value>*/=null:
    if values != null:
      this.values = values

  constructor.deserialize r/_protobuf.Reader:
    r.read-message:
      r.read-field 1:
        values = r.read-array _protobuf.PROTOBUF-TYPE-MESSAGE values:
          Value.deserialize r

  serialize w/_protobuf.Writer --as-field/int?=null --oneof/bool=false -> none:
    w.write-message-header this --as-field=as-field --oneof=oneof
    w.write-array _protobuf.PROTOBUF-TYPE-MESSAGE values --as-field=1: | value/Value | 
      value.serialize w

  num-fields-set -> int:
    return (values.is-empty ? 0 : 1)

  protobuf-size -> int:
    return (_protobuf.size-array _protobuf.PROTOBUF-TYPE-MESSAGE values --as-field=1)

// MESSAGE END: .google.protobuf.ListValue

