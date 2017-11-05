#!/usr/bin/env ruby

module TestModule
	def test_method
		return 1
	end
end

class User
	attr_accessor :id, :name, :valid, :data
end

class ExtendedUser
	extend TestModule
	attr_accessor :id
end

class UserHash < Hash ; end
user_hash = UserHash.new(0)
user_hash['data'] = 123

Customer = Struct.new(:name, :address, :valid, :age)
dave = Customer.new("Dave", "123 Main", false, 29)

user = User.new
user.id = 1
user.name = 'Test'
user.valid = true
user.data = { :some => true, 1 => 'extra', { :key => 1 } => 0x01 }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-valid.out'), 'w') { |f| f.write(Marshal.dump(user)) }

extended_user = ExtendedUser.new
extended_user.id = 2
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-object-extended.out'), 'w') { |f| f.write(Marshal.dump(extended_user)) }

bad_version = ["00000100", "00001001"].map { |i| i.to_i(2).chr }.join
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-invalid-version.out'), 'wb') { |f| f.write(bad_version) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-true.out'), 'wb') { |f| f.write(Marshal.dump(true)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-false.out'), 'wb') { |f| f.write(Marshal.dump(false)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-nil.out'), 'w') { |f| f.write(Marshal.dump(nil)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-1)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-122)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(1)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(122)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-one-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(123)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-one-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(255)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-one-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-256)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-one-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-124)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-two-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(256)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-two-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(65_535)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-two-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-65_536)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-two-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-257)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-three-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(65_536)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-three-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(16_777_215)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-three-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-16_777_216)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-three-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-65_537)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-four-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(16_777_216)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-four-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(1_073_741_823)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-four-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-1_073_741_824)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-four-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-16_777_217)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-float.out'), 'wb') { |f| f.write(Marshal.dump(-1.67320495432149)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-float-infinity.out'), 'wb') { |f| f.write(Marshal.dump(Float::INFINITY)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-float-negative-infinity.out'), 'wb') { |f| f.write(Marshal.dump(-Float::INFINITY)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-float-nan.out'), 'wb') { |f| f.write(Marshal.dump(Float::NAN)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-bignum.out'), 'wb') { |f| f.write(Marshal.dump(123456789 ** 4)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-string.out'), 'w') { |f| f.write(Marshal.dump("test_string")) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-symbol.out'), 'w') { |f| f.write(Marshal.dump(:test_symbol)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-symbol-array.out'), 'w') { |f| f.write(Marshal.dump([:hello, :hello])) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-complex-array.out'), 'w') { |f| f.write(Marshal.dump([:hello, :hello, [:hello, :test, 1, nil],1_000_000, true, false, nil, "string", "string"])) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-hash.out'), 'w') { |f| f.write(Marshal.dump({:simple => 'hash'})) }
hash_with_default = Hash.new("default_value")
hash_with_default['key'] = 1
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-hash-with-default.out'), 'w') { |f| f.write(Marshal.dump(hash_with_default)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-class.out'), 'w') { |f| f.write(Marshal.dump(User)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-module.out'), 'w') { |f| f.write(Marshal.dump(TestModule)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-regex.out'), 'w') { |f| f.write(Marshal.dump(Regexp.new("^[A-Za-z0-9]+$", Regexp::IGNORECASE | Regexp::MULTILINE | Regexp::EXTENDED))) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-struct.out'), 'w') { |f| f.write(Marshal.dump(dave)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-user-class.out'), 'w') { |f| f.write(Marshal.dump(user_hash)) }
