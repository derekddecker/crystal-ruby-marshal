# crystal-ruby-marshal

Provides a crystal API to serialize into and deserialize from marshalled binary 
Ruby objects. This is useful for reading things such as Rack session objects which 
are generally base64 encoded, encrypted marshalled ruby objects - and would otherwise
be inaccessible in your crystal application. 

# Quirks
This project is still experimental. `Marshal#dump` support is actively being developed
and is not yet supported in the current state. Due to differences in crystal and ruby, 
symbols cannot be created at runtime, so they are cast to strings.

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

### Unmarshal - type support

In the following examples I first provide the ruby code which generated the marshalled object, followed by the byte stream that was written by the ruby marshal, followed by the relevant crystal code to unmarshal the object.

#### true, false, nil
##### true
```ruby
File.open('marshalled-true.out', 'w') { |f| f.write(Marshal.dump(true)) }
```
```sh
$ xxd marshalled-true.out
0000000: 0408 54
```
```crystal
obj = Ruby::Marshal.load( File.read('marshalled-true.out') )
#=> #<Ruby::Marshal::True:0x10f0a7ff0>
puts obj.data
#=> true
```

##### false
```ruby
File.open('marshalled-false.out', 'w') { |f| f.write(Marshal.dump(false)) }
```
```sh
$ xxd marshalled-false.out
0000000: 0408 46
```
```crystal
obj = Ruby::Marshal.load( File.read('marshalled-false.out') )
#=> #<Ruby::Marshal::False:0x1096e9ff0>
puts obj.data
#=> false
```

##### nil
```ruby
File.open('marshalled-nil.out', 'w') { |f| f.write(Marshal.dump(nil)) }
```
```sh
$ xxd marshalled-nil.out
0000000: 0408 30
```
```crystal
obj = Ruby::Marshal.load( File.read('marshalled-nil.out') )
#=> #<Ruby::Marshal::Null:0x104682ff0> 
puts obj.data.inspect
#=> nil
```

#### Integers
```ruby
File.open( 'marshalled-positive-four-byte-integer-upper.out', 'w') { |f| f.write(Marshal.dump(1_073_741_823)) }
```
```sh
$ xxd marshalled-positive-four-byte-integer-upper.out
0000000: 0408 6904 ffff ff3f                      ..i....?
```
```crystal
obj = Ruby::Marshal.load( File.read('marshalled-positive-four-byte-integer-upper.out') )
#=> #<Ruby::Marshal::FourBytePositiveInt:0x1018d7ff0>
puts obj.data
#=> 1073741823
```

#### Symbols 
Symbols are cast to strings, as symbols in Crystal cannot be created at runtime.

```ruby
File.open( 'marshalled-symbol.out', 'w') { |f| f.write(Marshal.dump(:test_symbol)) }
```
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
```ruby
File.open( 'marshalled-symbol-array.out', 'w') { |f| f.write(Marshal.dump([:hello, :hello])) }
File.open( 'marshalled-complex-array.out', 'w') { |f| f.write(Marshal.dump([:hello, :hello, [:hello, :test, 1, nil],1_000_000, true, false, nil, "string", "string"])) }
```
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
Bignum is not currently in the crystal stdlib, so the data is simply stored in a byte slice and is not cast to a native data type.

```ruby
File.open( 'marshalled-bignum.out', 'w') { |f| f.write(Marshal.dump(123456789 ** 4)) }
```
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
```ruby
File.open( 'marshalled-class.out', 'w') { |f| f.write(Marshal.dump(User)) }
File.open( 'marshalled-module.out', 'w') { |f| f.write(Marshal.dump(TestModule)) }
```
```sh
$ xxd marshalled-class.out
0000000: 0408 6309 5573 6572                      ..c.User

$ xxd marshalled-module.out
0000000: 0408 6d0f 5465 7374 4d6f 6475 6c65       ..m.TestModule
```
```crystal
# Class
obj = Ruby::Marshal.load( File.read("marshalled-class.out") )
#=> #<Ruby::Marshal::Class:0x1097d8f00>
puts obj.data.inspect
#=> "User"

# Module
obj = Ruby::Marshal.load( File.read("marshalled-module.out") )
#=> #<Ruby::Marshal::Module:0x10d601ec0>
puts obj.data.inspect
#=> "TestModule"
```

#### Float
```ruby
File.open( 'marshalled-float.out', 'w') { |f| f.write(Marshal.dump(-1.67320495432149)) }
```
```sh
$ xxd marshalled-float.out
0000000: 0408 6616 2d31 2e36 3733 3230 3439 3534  ..f.-1.673204954
0000010: 3332 3134 39                             32149
```
```crystal
obj = Ruby::Marshal.load( File.read("marshalled-float.out") )
#=> #<Ruby::Marshal::Float:0x10071dec0>
puts obj.data.inspect
#=> -1.67320495432149
```

#### Hash and Hash with Default Value
`#data` returns a hash of `Ruby::Marshal::StreamObject`s, while `#raw_hash` returns a fully converted crystal hash.

Ruby::Marshal::HashWithDefault behaves the same, and respects the marshalled default value when accessing unset keys.

```ruby
File.open( 'marshalled-hash.out', 'w') { |f| f.write(Marshal.dump({:simple => 'hash'})) }
```
```sh
$ xxd marshalled-hash.out
0000000: 0408 7b06 3a0b 7369 6d70 6c65 4922 0968  ..{.:.simpleI".h
0000010: 6173 6806 3a06 4554                      ash.:.ET
```
```crystal
obj = Ruby::Marshal.load( File.read("marshalled-hash.out") )
#=> #<Ruby::Marshal::Float:0x10071dec0>
puts obj.data.inspect
#=> {#<Ruby::Marshal::Symbol:0x10a552e80 @size=6, @data="simple", @symbol_length=1> => #<Ruby::Marshal::InstanceObject:0x10a556ed0 @size=11, @num_instance_variables=#<Ruby::Marshal::OneByteInt:0x10a55dfb0 @size=1, @data=1>, @instance_variables={"E" => #<Ruby::Marshal::True:0x10a55df80 @size=0, @data=true>}, @data=#<Ruby::Marshal::String:0x10a552e40 @size=4, @data="hash">>}
puts obj.raw_hash.inspect
#=> {"simple" => "hash"}
```

#### Object
`Ruby::Marshal.load(::Class, IO)` and `Ruby::Marshal.load(::Class, ::String)` are provided as convenience methods for unmarshalling straight into a Crystal object. Any class passed to these methods must implement `#initialize(obj : ::Ruby::Marshal::StreamObject)` in order to read the marshalled data.

The `Ruby::Marshal.mapping` macro is provided as a convenience for simple marshalled objects. It will auto-unmarshal for you provided the correct schema for the data. 

Unlike the other datatypes, `#data` in the case of objects will return a `Ruby::Marshall::Null` object. To use an unmarshalled object, cast to `Ruby::Marshal::Object`. You can then reach the data by means of `#read_raw_attr(::String)` or `#read_attr(::String)`.

```ruby
class User
	attr_accessor :id, :name, :valid, :data
end

user = User.new
user.id = 1
user.name = 'Test'
user.valid = true
user.data = { :some => true, 1 => 'extra', { :key => 1 } => 0x01 }
File.open( 'marshalled-valid.out', 'w') { |f| f.write(Marshal.dump(user)) }

```
```sh
$ xxd marshalled-valid.out
0000000: 0408 6f3a 0955 7365 7209 3a08 4069 6469  ..o:.User.:.@idi
0000010: 063a 0a40 6e61 6d65 4922 0954 6573 7406  .:.@nameI".Test.
0000020: 3a06 4554 3a0b 4076 616c 6964 543a 0a40  :.ET:.@validT:.@
0000030: 6461 7461 7b08 3a09 736f 6d65 5469 0649  data{.:.someTi.I
0000040: 220a 6578 7472 6106 3b08 547b 063a 086b  ".extra.;.T{.:.k
0000050: 6579 6906 6906                           eyi.i.
```
```crystal
obj = Ruby::Marshal.load( File.read("marshalled-valid.out") )
#=> #<Ruby::Marshal::Object:0x10f393f00>
puts obj.data.inspect
#=> #<Ruby::Marshal::Null:0x104484fe0 @size=0, @data=nil>
puts obj.as(Ruby::Marshal::Object).read_attr("id").inspect
#=> #<Ruby::Marshal::OneByteInt:0x10be12fb0 @size=1, @data=1>
puts obj.as(Ruby::Marshal::Object).read_raw_attr("name").inspect
#=> "Test"

# Or unmarshal straight into a Crystal object
class User
	property :id, :name

	def initialize(object : Ruby::Marshal::StreamObject)
		object = object.as(Ruby::Marshal::Object)
		@id = object.read_raw_attr("id").as(::Int32)
		@name = object.read_raw_attr("name").as(::String)
	end
end

obj = Ruby::Marshal.load( User, File.read("marshalled-valid.out") )
puts obj.inspect
#=> #<User:0x10d5c85a0 @id=1, @name="Test">

# As a convenience to setting these classes up, use the `Ruby::Marshal.mapping` helper macro
class User
	Ruby::Marshal.mapping({ id: ::Int32, name: ::String })
end
```

#### Regular Expression
Contrary to the ruby documentation, ruby does not actually attach any Regex option data to the marshalled bytestream. Aside from that detail, the Regex source is unmarshalled as expected.

```ruby
File.open( 'marshalled-regex.out', 'w') { |f| f.write(Marshal.dump(Regexp.new("^[A-Za-z0-9]+$", Regexp::IGNORECASE | Regexp::MULTILINE | Regexp::EXTENDED))) }
```
```sh
$ xxd marshalled-regex.out
0000000: 0408 492f 135e 5b41 2d5a 612d 7a30 2d39  ..I/.^[A-Za-z0-9
0000010: 5d2b 2407 063a 0645 46                   ]+$..:.EF
```
```crystal
obj = Ruby::Marshal.load( File.read("marshalled-regex.out") )
#=> #<Ruby::Marshal::InstanceObject:0x104db2f00>
puts obj.data.inspect
#=> /^[A-Za-z0-9]+$/
obj.data.as(::Regex).match("howdyabc")
#=> #<Regex::MatchData "howdyabc">
```

#### String
Strings are marshalled in ruby as objects with instance variables, so they are unmarshalled as `Ruby::Marshal::InstanceObject`s. You can access the raw string value in `#data`. The encoding is set in the `E` instance variable.

```ruby
File.open( 'marshalled-string.out', 'w') { |f| f.write(Marshal.dump("test_string")) }
```
```sh
$ xxd marshalled-string.out
0000000: 0408 4922 1074 6573 745f 7374 7269 6e67  ..I".test_string
0000010: 063a 0645 54                             .:.ET
```
```crystal
obj = Ruby::Marshal.load( File.read("marshalled-string.out") )
#=> #<Ruby::Marshal::InstanceObject:0x1083dbf00>
puts obj.data.inspect
#=> "test_string"
puts obj.inspect
#=> #<Ruby::Marshal::InstanceObject:0x108640f00 @size=18, @num_instance_variables=#<Ruby::Marshal::OneByteInt:0x108647fe0 @size=1, @data=1>, @instance_variables={"E" => #<Ruby::Marshal::True:0x108647fb0 @size=0, @data=true>}, @data=#<Ruby::Marshal::String:0x10863ce80 @size=11, @data="test_string">>
```

#### Struct
Similar to an Object, structs can be unmarshalled and loaded into a crystal struct by passing the class to `Ruby::Marshal.load`. The passed class must the implement `#initialize(::Ruby::Marshal::StreamObject)` method.

```ruby
Customer = Struct.new(:name, :address, :valid, :age)
dave = Customer.new("Dave", "123 Main", false, 29)

File.open( 'marshalled-struct.out', 'w') { |f| f.write(Marshal.dump(dave)) }
```
```sh
$ xxd marshalled-struct.out
0000000: 0408 533a 0d43 7573 746f 6d65 7209 3a09  ..S:.Customer.:.
0000010: 6e61 6d65 4922 0944 6176 6506 3a06 4554  nameI".Dave.:.ET
0000020: 3a0c 6164 6472 6573 7349 220d 3132 3320  :.addressI".123
0000030: 4d61 696e 063b 0754 3a0a 7661 6c69 6446  Main.;.T:.validF
0000040: 3a08 6167 6569 22                        :.agei"
```
```crystal
struct Customer
  property :name, :address, :valid, :age

	def initialize(obj : ::Ruby::Marshal::StreamObject)
		obj = obj.as(::Ruby::Marshal::Struct)
		@name = obj.read_raw_attr("name").as(::String)
		@address = obj.read_raw_attr("address").as(::String)
		@valid = obj.read_raw_attr("valid").as(::Bool)
		@age = obj.read_raw_attr("age").as(::Int32)
	end
end

puts Ruby::Marshal.load( Customer, File.read("marshalled-struct.out") )
#=> Customer(@name="Dave", @address="123 Main", @valid=false, @age=29)
```

#### User Class
Per the Ruby documentation, a `User` class is any class which extends the core Ruby `String`, `Regexp`, `Array`, or `Hash` classes.

```ruby
class UserHash < Hash ; end
user_hash = UserHash.new(0)
user_hash['data'] = 123

File.open( 'marshalled-user-class.out', 'w') { |f| f.write(Marshal.dump(user_hash)) }
```
```sh
$ xxd marshalled-user-class.out
0000000: 0408 433a 0d55 7365 7248 6173 687d 0649  ..C:.UserHash}.I
0000010: 2209 6461 7461 063a 0645 5469 017b 6900  ".data.:.ETi.{i.
```
```crystal
obj = Ruby::Marshal.load( File.read("marshalled-float.out") )
#=> #<Ruby::Marshal::UserClass:0x107fb5d20>
puts obj.data.inspect
#=> #<Ruby::Marshal::HashWithDefault:0x10970cd50 @size=19, @data={#<Ruby::Marshal::InstanceObject:0x10970cd20 @size=11, @num_instance_variables=#<Ruby::Marshal::OneByteInt:0x109711ed0 @size=1, @data=1>, @instance_variables={"E" => #<Ruby::Marshal::True:0x109711ea0 @size=0, @data=true>}, @data=#<Ruby::Marshal::String:0x109708cc0 @size=4, @data="data">> => #<Ruby::Marshal::OneBytePositiveInt:0x109711e90 @size=1, @data=123>}, @num_keys=#<Ruby::Marshal::OneByteInt:0x109711ef0 @size=1, @data=1>, @default_value=#<Ruby::Marshal::ZeroByteInt:0x109711e80 @size=1, @data=0>>
puts Ruby::Marshal.load( File.read("marshalled-user-class.out") ).data.as(Ruby::Marshal::HashWithDefault).raw_hash.inspect
#=> {"data" => 123}
```


## Todo
 - [ ] Marshal.dump (WIP)
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
