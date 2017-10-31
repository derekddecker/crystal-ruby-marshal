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

###Require it
```crystal
require "ruby-marshal"
```

###Use it
```crystal
# Load a marshalled ruby object from file
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
puts obj.data
#=> nil
```

#### Fixnum and long
#### Symbols and Byte Sequence
#### Object References
#### Instance Variables
#### Extended
#### Array
#### Bignum
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
