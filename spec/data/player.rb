#!/usr/bin/env ruby
#
class Player

	attr_accessor :id, :name, :valid, :data

end

player = Player.new
player.id = 1
player.name = 'Test'
player.valid = true
player.data = { :some => true, 1 => 'extra', { :key => 1 } => 0x01 }

File.open( File.join(File.dirname( __FILE__ ), 'marshalled-valid.out'), 'w') { |f| f.write(Marshal.dump(player)) }

bad_version = ["00000100", "00001001"].map { |i| i.to_i(2).chr }.join
File.open( File.join(File.dirname( __FILE__ ), 'marshalled-invalid-version.out'), 'wb') { |f| f.write(bad_version) }
