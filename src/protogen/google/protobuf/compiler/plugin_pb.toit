// Code generated by protoc-gen-toit. DO NOT EDIT.
// source: google/protobuf/compiler/plugin.proto

import .....protobuf as _protobuf
import core as _core
import ....google.protobuf.descriptor_pb as _descriptor

// MESSAGE START: .google.protobuf.compiler.Version
class Version extends _protobuf.Message:
  major/int := 0
  minor/int := 0
  patch/int := 0
  suffix/string := ""

  constructor
      --major/int?=null
      --minor/int?=null
      --patch/int?=null
      --suffix/string?=null:
    if major != null:
      this.major = major
    if minor != null:
      this.minor = minor
    if patch != null:
      this.patch = patch
    if suffix != null:
      this.suffix = suffix

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        major = r.read_primitive _protobuf.PROTOBUF_TYPE_INT32
      r.read_field 2:
        minor = r.read_primitive _protobuf.PROTOBUF_TYPE_INT32
      r.read_field 3:
        patch = r.read_primitive _protobuf.PROTOBUF_TYPE_INT32
      r.read_field 4:
        suffix = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_INT32 major --as_field=1
    w.write_primitive _protobuf.PROTOBUF_TYPE_INT32 minor --as_field=2
    w.write_primitive _protobuf.PROTOBUF_TYPE_INT32 patch --as_field=3
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING suffix --as_field=4

  num_fields_set -> int:
    return (major == 0 ? 0 : 1)
      + (minor == 0 ? 0 : 1)
      + (patch == 0 ? 0 : 1)
      + (suffix.is_empty ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_INT32 major --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_INT32 minor --as_field=2)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_INT32 patch --as_field=3)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING suffix --as_field=4)

// MESSAGE END: .google.protobuf.compiler.Version

// MESSAGE START: .google.protobuf.compiler.CodeGeneratorRequest
class CodeGeneratorRequest extends _protobuf.Message:
  file_to_generate/List/*<string>*/ := []
  parameter/string := ""
  proto_file/List/*<_descriptor.FileDescriptorProto>*/ := []
  source_file_descriptors/List/*<_descriptor.FileDescriptorProto>*/ := []
  compiler_version/Version := Version

  constructor
      --file_to_generate/List?/*<string>*/=null
      --parameter/string?=null
      --proto_file/List?/*<_descriptor.FileDescriptorProto>*/=null
      --source_file_descriptors/List?/*<_descriptor.FileDescriptorProto>*/=null
      --compiler_version/Version?=null:
    if file_to_generate != null:
      this.file_to_generate = file_to_generate
    if parameter != null:
      this.parameter = parameter
    if proto_file != null:
      this.proto_file = proto_file
    if source_file_descriptors != null:
      this.source_file_descriptors = source_file_descriptors
    if compiler_version != null:
      this.compiler_version = compiler_version

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        file_to_generate = r.read_array _protobuf.PROTOBUF_TYPE_STRING file_to_generate:
          r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 2:
        parameter = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 15:
        proto_file = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE proto_file:
          _descriptor.FileDescriptorProto.deserialize r
      r.read_field 17:
        source_file_descriptors = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE source_file_descriptors:
          _descriptor.FileDescriptorProto.deserialize r
      r.read_field 3:
        compiler_version = Version.deserialize r

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_array _protobuf.PROTOBUF_TYPE_STRING file_to_generate --as_field=1: | value/string | 
      w.write_primitive _protobuf.PROTOBUF_TYPE_STRING value --in_array
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING parameter --as_field=2
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE proto_file --as_field=15: | value/_descriptor.FileDescriptorProto | 
      value.serialize w
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE source_file_descriptors --as_field=17: | value/_descriptor.FileDescriptorProto | 
      value.serialize w
    compiler_version.serialize w --as_field=3

  num_fields_set -> int:
    return (file_to_generate.is_empty ? 0 : 1)
      + (parameter.is_empty ? 0 : 1)
      + (proto_file.is_empty ? 0 : 1)
      + (source_file_descriptors.is_empty ? 0 : 1)
      + (compiler_version.is_empty ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_array _protobuf.PROTOBUF_TYPE_STRING file_to_generate --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING parameter --as_field=2)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE proto_file --as_field=15)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE source_file_descriptors --as_field=17)
      + (_protobuf.size_embedded_message (compiler_version.protobuf_size) --as_field=3)

// MESSAGE END: .google.protobuf.compiler.CodeGeneratorRequest

// MESSAGE START: .google.protobuf.compiler.CodeGeneratorResponse
// ENUM START: CodeGeneratorResponse_Feature
CodeGeneratorResponse_Feature_FEATURE_NONE/int/*enum<CodeGeneratorResponse_Feature>*/ ::= 0
CodeGeneratorResponse_Feature_FEATURE_PROTO3_OPTIONAL/int/*enum<CodeGeneratorResponse_Feature>*/ ::= 1
CodeGeneratorResponse_Feature_FEATURE_SUPPORTS_EDITIONS/int/*enum<CodeGeneratorResponse_Feature>*/ ::= 2
// ENUM END: .google.protobuf.compiler.CodeGeneratorResponse.Feature

// MESSAGE START: .google.protobuf.compiler.CodeGeneratorResponse.File
class CodeGeneratorResponse_File extends _protobuf.Message:
  name/string := ""
  insertion_point/string := ""
  content/string := ""
  generated_code_info/_descriptor.GeneratedCodeInfo := _descriptor.GeneratedCodeInfo

  constructor
      --name/string?=null
      --insertion_point/string?=null
      --content/string?=null
      --generated_code_info/_descriptor.GeneratedCodeInfo?=null:
    if name != null:
      this.name = name
    if insertion_point != null:
      this.insertion_point = insertion_point
    if content != null:
      this.content = content
    if generated_code_info != null:
      this.generated_code_info = generated_code_info

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        name = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 2:
        insertion_point = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 15:
        content = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 16:
        generated_code_info = _descriptor.GeneratedCodeInfo.deserialize r

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING insertion_point --as_field=2
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING content --as_field=15
    generated_code_info.serialize w --as_field=16

  num_fields_set -> int:
    return (name.is_empty ? 0 : 1)
      + (insertion_point.is_empty ? 0 : 1)
      + (content.is_empty ? 0 : 1)
      + (generated_code_info.is_empty ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING name --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING insertion_point --as_field=2)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING content --as_field=15)
      + (_protobuf.size_embedded_message (generated_code_info.protobuf_size) --as_field=16)

// MESSAGE END: .google.protobuf.compiler.CodeGeneratorResponse.File

class CodeGeneratorResponse extends _protobuf.Message:
  error/string := ""
  supported_features/int := 0
  file/List/*<CodeGeneratorResponse_File>*/ := []

  constructor
      --error/string?=null
      --supported_features/int?=null
      --file/List?/*<CodeGeneratorResponse_File>*/=null:
    if error != null:
      this.error = error
    if supported_features != null:
      this.supported_features = supported_features
    if file != null:
      this.file = file

  constructor.deserialize r/_protobuf.Reader:
    r.read_message:
      r.read_field 1:
        error = r.read_primitive _protobuf.PROTOBUF_TYPE_STRING
      r.read_field 2:
        supported_features = r.read_primitive _protobuf.PROTOBUF_TYPE_UINT64
      r.read_field 15:
        file = r.read_array _protobuf.PROTOBUF_TYPE_MESSAGE file:
          CodeGeneratorResponse_File.deserialize r

  serialize w/_protobuf.Writer --as_field/int?=null --oneof/bool=false -> none:
    w.write_message_header this --as_field=as_field --oneof=oneof
    w.write_primitive _protobuf.PROTOBUF_TYPE_STRING error --as_field=1
    w.write_primitive _protobuf.PROTOBUF_TYPE_UINT64 supported_features --as_field=2
    w.write_array _protobuf.PROTOBUF_TYPE_MESSAGE file --as_field=15: | value/CodeGeneratorResponse_File | 
      value.serialize w

  num_fields_set -> int:
    return (error.is_empty ? 0 : 1)
      + (supported_features == 0 ? 0 : 1)
      + (file.is_empty ? 0 : 1)

  protobuf_size -> int:
    return (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_STRING error --as_field=1)
      + (_protobuf.size_primitive _protobuf.PROTOBUF_TYPE_UINT64 supported_features --as_field=2)
      + (_protobuf.size_array _protobuf.PROTOBUF_TYPE_MESSAGE file --as_field=15)

// MESSAGE END: .google.protobuf.compiler.CodeGeneratorResponse

