// Code generated by protoc-gen-toit. DO NOT EDIT.
// source: google/protobuf/api.proto

import ....protobuf as _protobuf
import core as _core
import ...google.protobuf.source_context_pb as _source_context
import ...google.protobuf.type_pb as _type

// MESSAGE START: .google.protobuf.Api
class Api extends _protobuf.Message:
  name/string := ""
  methods/List/*<Method>*/ := []
  options/List/*<_type.Option>*/ := []
  version/string := ""
  source_context/_source_context.SourceContext := _source_context.SourceContext
  mixins/List/*<Mixin>*/ := []
  syntax/int/*enum<_type.Syntax>*/ := 0

  constructor
      --name/string?=null
      --methods/List?/*<Method>*/=null
      --options/List?/*<_type.Option>*/=null
      --version/string?=null
      --source_context/_source_context.SourceContext?=null
      --mixins/List?/*<Mixin>*/=null
      --syntax/int?/*enum<_type.Syntax>?*/=null:
    if name != null:
      this.name = name
    if methods != null:
      this.methods = methods
    if options != null:
      this.options = options
    if version != null:
      this.version = version
    if source_context != null:
      this.source_context = source_context
    if mixins != null:
      this.mixins = mixins
    if syntax != null:
      this.syntax = syntax

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        name = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 2:
        methods = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE methods:
          Method.deserialize r
      r.read_field 3:
        options = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE options:
          _type.Option.deserialize r
      r.read_field 4:
        version = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 5:
        source_context = _source_context.SourceContext.deserialize r
      r.read_field 6:
        mixins = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE mixins:
          Mixin.deserialize r
      r.read_field 7:
        syntax = r.read_primitive _protobuf.PROTOBUF_TYPE_ENUM

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE methods --as_field=2: | value/Method | 
      value.serialize w
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE options --as_field=3: | value/_type.Option | 
      value.serialize w
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING version --as_field=4
    source_context.serialize w --as_field=5
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE mixins --as_field=6: | value/Mixin | 
      value.serialize w
    w.write_primitive _protobuf.PROTOBUF_TYPE_ENUM syntax --as_field=7

  num_fields_set -> int:
    return (name.is_empty ? 0 : 1)
      + (methods.is_empty ? 0 : 1)
      + (options.is_empty ? 0 : 1)
      + (version.is_empty ? 0 : 1)
      + (source_context.is_empty ? 0 : 1)
      + (mixins.is_empty ? 0 : 1)
      + (syntax == 0 ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE methods --as_field=2)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE options --as_field=3)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING version --as_field=4)
      + (_protobuf.size_embedded_message (source_context.protobuf_size) --as_field=5)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE mixins --as_field=6)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_ENUM syntax --as_field=7)

// MESSAGE END: .google.protobuf.Api

// MESSAGE START: .google.protobuf.Method
class Method extends _protobuf.Message:
  name/string := ""
  request_type_url/string := ""
  request_streaming/bool := false
  response_type_url/string := ""
  response_streaming/bool := false
  options/List/*<_type.Option>*/ := []
  syntax/int/*enum<_type.Syntax>*/ := 0

  constructor
      --name/string?=null
      --request_type_url/string?=null
      --request_streaming/bool?=null
      --response_type_url/string?=null
      --response_streaming/bool?=null
      --options/List?/*<_type.Option>*/=null
      --syntax/int?/*enum<_type.Syntax>?*/=null:
    if name != null:
      this.name = name
    if request_type_url != null:
      this.request_type_url = request_type_url
    if request_streaming != null:
      this.request_streaming = request_streaming
    if response_type_url != null:
      this.response_type_url = response_type_url
    if response_streaming != null:
      this.response_streaming = response_streaming
    if options != null:
      this.options = options
    if syntax != null:
      this.syntax = syntax

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        name = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 2:
        request_type_url = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 3:
        request_streaming = r.read_primitive _protobuf.PROTOBUF_TYPE_BOOL
      r.read_field 4:
        response_type_url = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 5:
        response_streaming = r.read_primitive _protobuf.PROTOBUF_TYPE_BOOL
      r.read_field 6:
        options = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE options:
          _type.Option.deserialize r
      r.read_field 7:
        syntax = r.read_primitive _protobuf.PROTOBUF_TYPE_ENUM

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING request_type_url --as_field=2
    w.write_primitive _protobuf.PROTOBUF_TYPE_BOOL request_streaming --as_field=3
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING response_type_url --as_field=4
    w.write_primitive _protobuf.PROTOBUF_TYPE_BOOL response_streaming --as_field=5
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE options --as_field=6: | value/_type.Option | 
      value.serialize w
    w.write_primitive _protobuf.PROTOBUF_TYPE_ENUM syntax --as_field=7

  num_fields_set -> int:
    return (name.is_empty ? 0 : 1)
      + (request_type_url.is_empty ? 0 : 1)
      + (request_streaming == false ? 0 : 1)
      + (response_type_url.is_empty ? 0 : 1)
      + (response_streaming == false ? 0 : 1)
      + (options.is_empty ? 0 : 1)
      + (syntax == 0 ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING request_type_url --as_field=2)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_BOOL request_streaming --as_field=3)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING response_type_url --as_field=4)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_BOOL response_streaming --as_field=5)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE options --as_field=6)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_ENUM syntax --as_field=7)

// MESSAGE END: .google.protobuf.Method

// MESSAGE START: .google.protobuf.Mixin
class Mixin extends _protobuf.Message:
  name/string := ""
  root/string := ""

  constructor
      --name/string?=null
      --root/string?=null:
    if name != null:
      this.name = name
    if root != null:
      this.root = root

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        name = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 2:
        root = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING root --as_field=2

  num_fields_set -> int:
    return (name.is_empty ? 0 : 1)
      + (root.is_empty ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING root --as_field=2)

// MESSAGE END: .google.protobuf.Mixin

