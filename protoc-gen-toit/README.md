# protoc-gen-toit
The `protoc-gen-toit` is a compiler plugin to protoc. It augments the protoc compiler
so it knows how to generate Toit specific code for a given .proto file.

## Install

Download the protocol compiler plugin for Toit:

```
go install github.com/toitware/toit-protobuf/protoc-gen-toit@latest
```

Update your `PATH` so that the `protoc` compiler can find the plugin:

```
export PATH="$PATH:$(go env GOPATH)/bin"
```

## Generate

In order to generate toit files use:

```
protoc <proto-file> --toit_out=.
```

## Options

The compiler plugin has some options that can be enabled using the `--toit_opt` flag to `protoc`:

### Constructor Initializers

By default the `constructor_initializers` is set to 0, and the generator only produces
a simple default constructor.

If the flag is set to `1` each generated class constructor will have flags to initialize
the object fields.

See the Makefile and generated output of [../examples/helloworld](../examples/helloworld).

### Import Library

The `import_library` flag can be used to change the import paths. The setting can be set multiple
times. Using `import_library=<from>=<to>` will take all proto imports prefixed with `<from>` and
replace that prefix with `<to>` in the toit code.

See the Makefile and generated output of [../examples/imports](../examples/imports).

### Core Objects

By default the `core_objects` flags is set to 1.

If set to `1` the built-in protobuf objects such as Timestamp, Duration etc. are mapped directly
to their counterparts in toit.

See the Makefile and generated output of [../examples/core_objects](../examples/core_objects).

## Development
To have automatic checks for copyright and MIT notices, run

```
git config core.hooksPath .githooks
```

If a file doesn't need a copyright/MIT notice, use the following to skip
the check:
```
git commit --no-verify
```
