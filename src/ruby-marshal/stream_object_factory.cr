require "./stream_objects"

module Ruby::Marshal

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			case stream[0]
				when 0x00
					# The value of the integer is 0. No bytes follow.
					object = ZeroByteInt.new
				when 0x01
					# The total size of the integer is two bytes. The following byte 
					# is a positive integer in the range of 0 through 255. Only values 
					# between 123 and 255 should be represented this way to save bytes.
					object = OneBytePositiveInt.new
				when 0xff
					# The total size of the integer is two bytes. The following byte is a negative 
					# integer in the range of -1 through -256.
					object = OneByteNegativeInt.new
				when 0x02
					# The total size of the integer is three bytes. The following two bytes are a 
					# positive little-endian integer.
					object = TwoBytePositiveInt.new
				when 0xfe
					# The total size of the integer is three bytes. The following two bytes are a 
					# negative little-endian integer.
					object = TwoByteNegativeInt.new
				when 0x03
					# The total size of the integer is four bytes. The following three bytes are a 
					# positive little-endian integer.
					object = ThreeBytePositiveInt.new
				when 0xfd
					# The total size of the integer is two bytes. The following three bytes are a 
					# negative little-endian integer.
					return ThreeByteNegativeInt.new
				when 0x04
					# The total size of the integer is five bytes. The following four bytes are a 
					# positive little-endian integer. For compatibility with 32 bit ruby, only 
					# Fixnums less than 1073741824 should be represented this way. For sizes of 
					# stream objects full precision may be used.
					return FourBytePositiveInt.new
				when 0xfc
					# The total size of the integer is two bytes. The following four bytes are a 
					# negative little-endian integer. For compatibility with 32 bit ruby, only 
					# Fixnums greater than -10737341824 should be represented this way. For sizes 
					# of stream objects full precision may be used.
					return FourByteNegativeInt.new
				when ":"
					return Symbol.new(stream)
				else
					return NullStreamObject.new
			end
			return object
		end

	end

end
