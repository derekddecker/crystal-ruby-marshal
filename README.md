# crystal-ruby-marshal

Provides a crystal API to serialize into and deserialize from marshalled binary 
Ruby objects. This is useful for reading things such as Rack session objects which 
are generally base64 encoded, encrypted marshalled ruby objects - and would otherwise
be inaccessible in your crystal application. 

# Quirks
This project is still experimental. Due to differences in crystal and ruby, symbols 
cannot be created at runtime, so they are cast to strings.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  ruby-marshal:
    github: derekddecker/crystal-ruby-marshal
```

## Usage

### Require it
```crystal
require "ruby-marshal"
```

### Use it
```crystal
# Load a marshalled ruby object from String
Ruby::Marshal.load( File.read( "marshalled.object" ) )

# Load a marshalled ruby object from IO
Ruby::Marshal.load( File.open("marshalled.object") )
```

`Ruby::Marshal.load` will return a subclass of `Ruby::Marshal::StreamObject` which wraps the unmarshalled object. To access the underlying / raw crystal data structure, call `#data` on the `StreamObject`. See below for the particulars on a per-datatype basis.

### Unmarshal type support:

#### true, false, nil
```crystal
# True
obj = Ruby::Marshal.load("\u{04}\u{08}T")
#=> #<Ruby::Marshal::True:0x10f0a7ff0>
puts obj.data
#=> true

# False
obj = Ruby::Marshal.load("\u{04}\u{08}F")
#=> #<Ruby::Marshal::False:0x1096e9ff0>
puts obj.data
#=> false

# nil
obj = Ruby::Marshal.load("\u{04}\u{08}\u{30}")
#=> #<Ruby::Marshal::Null:0x104682ff0> 
puts obj.data.inspect
#=> nil
```

#### Integers
```crystal
obj = Ruby::Marshal.load("\u{04}\u{08}\u{69}\u{04}\u{ff}\u{ff}\u{ff}\u{3f}")
#=> #<Ruby::Marshal::FourBytePositiveInt:0x1018d7ff0>
puts obj.data
#=> 1073741823
```

#### Symbols 
Symbols are cast to strings, as symbols in Crystal cannot be created at runtime.
```sh
$ xxd marshalled-symbol.out
0000000: 0408 3a10 7465 7374 5f73 796d 626f 6c    ..:.test_symbol
```

```crystal
obj = Ruby::Marshal.load( File.read("marshalled-symbol.out") )
#=> #<Ruby::Marshal::Symbol:0x11035dec0>
puts obj.data.inspect
#=> "test_symbol"
```

#### Array
```sh
$ xxd marshalled-symbol-array.out
0000000: 0408 5b07 3a0a 6865 6c6c 6f3b 00         ..[.:.hello;.

$ xxd marshalled-complex-array.out
0000000: 0408 5b0e 3a0a 6865 6c6c 6f3b 005b 093b  ..[.:.hello;.[.;
0000010: 003a 0974 6573 7469 0630 6903 4042 0f54  .:.testi.0i.@B.T
0000020: 4630 4922 0b73 7472 696e 6706 3a06 4554  F0I".string.:.ET
0000030: 4922 0b73 7472 696e 6706 3b07 54         I".string.;.T
```

```crystal
# simple array
obj = Ruby::Marshal.load( File.read("marshalled-symbol-array.out") )
#=> #<Ruby::Marshal::Array:0x10be35f00>
puts obj.data.inspect
#=> ["hello", "hello"]

# a more complex array
obj = Ruby::Marshal.load( File.read("marshalled-complex-array.out") )
#=> #<Ruby::Marshal::Array:0x10b3f7f00>
puts obj.data.inspect
#=> ["hello", "hello", ["hello", "test", 1, nil], 1000000, true, false, nil, "string", "string"]
```

#### Bignum
Bignum is not currently in the Crystal-lang stdlib, so the data is simply stored in a byte slice as not cast to a native data type.

```sh
$ xxd marshalled-bignum.out
0000000: 0408 6c2b 0cb1 1ba5 47d0 4606 6776 1546  ..l+....G.F.gv.F
0000010: 1c74 0b                                  .t.
```

```crystal
obj = Ruby::Marshal.load( File.read("marshalled-bignum.out") )
#=> #<Ruby::Marshal::BigNum:0x10e9ccf00>
puts obj.data.inspect
#=> Bytes[177, 27, 165, 71, 208, 70, 6, 103, 118, 21, 70, 28, 116, 11]
```

#### Class and Module
#### Float
#### Hash and Hash with Default Value
#### Object
#### Regular Expression
#### String
#### Struct
#### User Class

## Todo
 - [ ] Data
 - [ ] User Defined
 - [ ] User Marshal

## Contributing

1. Fork it ( https://github.com/derekddecker/crystal-ruby-marshal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [derekddecker](https://github.com/derekddecker) Derek Decker - creator, maintainer
