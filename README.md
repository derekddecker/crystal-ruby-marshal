# crystal-ruby-marshal

Provides a crystal-lang API to serialize into and deserialize from marshalled binary 
Ruby objects. This is useful for reading things such as Rack session objects which 
are generally base64 encoded, encrypted marshalled ruby objects. 

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

## Contributing

1. Fork it ( https://github.com/derekddecker/crystal-ruby-marshal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [derekddecker](https://github.com/derekddecker) Derek Decker - creator, maintainer
