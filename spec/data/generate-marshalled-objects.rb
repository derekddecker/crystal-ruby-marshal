#!/usr/bin/env ruby
#
class User

	attr_accessor :id, :name, :valid, :data

end

player = User.new
player.id = 1
player.name = 'Test'
player.valid = true
player.data = { :some => true, 1 => 'extra', { :key => 1 } => 0x01 }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-valid.out'), 'w') { |f| f.write(Marshal.dump(player)) }

bad_version = ["00000100", "00001001"].map { |i| i.to_i(2).chr }.join
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-invalid-version.out'), 'wb') { |f| f.write(bad_version) }

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
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-two-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-32_768)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-two-byte-integer-lower-wtf.out'), 'wb') { |f| f.write(Marshal.dump(-32_770)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-two-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-257)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-three-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(65_536)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-three-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(16_776_960)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-three-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-8_388_480)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-three-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-32_769)) }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-four-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(65_536)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-positive-four-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(2_147_483_647)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-four-byte-integer-lower.out'), 'wb') { |f| f.write(Marshal.dump(-2_147_483_648)) }
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-negative-four-byte-integer-upper.out'), 'wb') { |f| f.write(Marshal.dump(-32_769)) }
