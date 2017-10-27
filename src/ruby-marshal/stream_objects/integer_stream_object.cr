require "./stream_object"

module Ruby::Marshal


	abstract class IntegerStreamObject < StreamObject

    @data : Int32
    getter :data

		def initialize(size : Int32)
			super(size)
      @data = Int32.new(0x00)
		end

		def self.get(stream : Bytes)
			case stream.first
				when 0x00
					# The value of the integer is 0. No bytes follow.
					return ZeroByteInt.new(stream)
				when 0x01
					# The total size of the integer is two bytes. The following byte
					# is a positive integer in the range of 0 through 255. Only values
					# between 123 and 255 should be represented this way to save bytes.
					return OneBytePositiveInt.new(stream)
				when 0xff
					# The total size of the integer is two bytes. The following byte is a negative
					# integer in the range of -1 through -256.
					return OneByteNegativeInt.new(stream)
				when 0x02
					# The total size of the integer is three bytes. The following two bytes are a
					# positive little-endian integer.
					return TwoBytePositiveInt.new(stream)
				when 0xfe
					# The total size of the integer is three bytes. The following two bytes are a
					# negative little-endian integer.
					return TwoByteNegativeInt.new(stream)
				when 0x03
					# The total size of the integer is four bytes. The following three bytes are a
					# positive little-endian integer.
					return ThreeBytePositiveInt.new(stream)
				when 0xfd
					# The total size of the integer is two bytes. The following three bytes are a
					# negative little-endian integer.
					return ThreeByteNegativeInt.new(stream)
				when 0x04
					# The total size of the integer is five bytes. The following four bytes are a
					# positive little-endian integer. For compatibility with 32 bit ruby, only
					# Fixnums less than 1073741824 should be represented this way. For sizes of
					# stream objects full precision may be used.
					return FourBytePositiveInt.new(stream)
				when 0xfc
					# The total size of the integer is two bytes. The following four bytes are a
					# negative little-endian integer. For compatibility with 32 bit ruby, only
					# Fixnums greater than -10737341824 should be represented this way. For sizes
					# of stream objects full precision may be used.
					return FourByteNegativeInt.new(stream)
				else
					return OneByteInt.new(stream)
				end
		end

		def stream_size
			# 1 for the 8 bit identifier "i"
			# 1 for the length byte
			return (1 + 1 + @size)
		end

	end

end
