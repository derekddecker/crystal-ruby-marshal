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

Require it
```crystal
require "ruby-marshal"
```

Use it
```crystal
# Load a marshalled ruby object from file
Ruby::Marshal.load( File.read( "marshalled.object" ) )

# Load a marshalled ruby object from IO
Ruby::Marshal.load( File.open("marshalled.object") )
```

## Todo
 - [x] "true, false, nil¶ ↑"
 - [x] "Fixnum and long¶ ↑"
 - [x] "Symbols and Byte Sequence¶ ↑"
 - [x] "Object References¶ ↑"
 - [x] "Instance Variables¶ ↑"
 - [] "Extended¶ ↑"
 - [x] "Array¶ ↑"
 - [] "Bignum¶ ↑"
 - [] "Class and Module¶ ↑"
 - [] "Data¶ ↑"
 - [] "Float¶ ↑"
 - [x] "Hash and Hash with Default Value¶ ↑"
 - [] "Module and Old Module¶ ↑"
 - [] "Object¶ ↑" 
 - [] "Regular Expression¶ ↑"
 - [x] "String¶ ↑"
 - [] "Struct¶ ↑"
 - [] "User Class¶ ↑"
 - [] "User Defined¶ ↑"
 - [] "User Marshal¶ ↑"

## Contributing

1. Fork it ( https://github.com/derekddecker/crystal-ruby-marshal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [derekddecker](https://github.com/derekddecker) Derek Decker - creator, maintainer
