module Ruby::Marshal

	abstract class StreamObject

		getter :id, :size, :data
		@data : UInt8 | Int8 | UInt16 | Int16 | UInt32 | Int32 | ::Symbol | ::Nil

		def initialize(@id : Int32, @size : Int32)
		end

		abstract def read(stream : Bytes)

	end

	class NullStreamObject < StreamObject

		def initialize
			super(0x00, 0x00)
			@data = 0x00
		end

		def read(stream : Bytes)
			# noop
			@data = 0x00
		end

	end

	ZERO_BYTE_INT_ID = 0x00
	ZERO_BYTE_INT_LENGTH = 0x00
	class ZeroByteInt < StreamObject

		def initialize
			super(ZERO_BYTE_INT_ID, ZERO_BYTE_INT_LENGTH)
			@data = 0x00
		end

		def read(stream : Bytes)
			# noop
			@data = 0x00
		end

	end

	ONE_BYTE_POSITIVE_INT_ID = 0x01
	ONE_BYTE_POSITIVE_INT_LENGTH = 0x01
	class OneBytePositiveInt < StreamObject

		def initialize
			super(ONE_BYTE_POSITIVE_INT_ID, ONE_BYTE_POSITIVE_INT_LENGTH)
			@data = UInt8.new(0)
		end

		def read(stream : Bytes)
			@data = UInt8.new(stream[1, size].join)
		end

	end

	ONE_BYTE_NEGATIVE_INT_ID = 0xff
	ONE_BYTE_NEGATIVE_INT_LENGTH = 0x01
	class OneByteNegativeInt < StreamObject
	
		def initialize
			super(ONE_BYTE_NEGATIVE_INT_ID, ONE_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int16.new(0)
		end

		def read(stream : Bytes)
			@data = Int16.new(stream[1, size].join)
		end

	end

	TWO_BYTE_POSITIVE_INT_ID = 0x02
	TWO_BYTE_POSITIVE_INT_LENGTH = 0x02
	class TwoBytePositiveInt < StreamObject
	
		def initialize
			super(TWO_BYTE_POSITIVE_INT_ID, TWO_BYTE_POSITIVE_INT_LENGTH)
			@data = UInt16.new(0)
		end

		def read(stream : Bytes)
			@data = UInt16.new(stream[1, size].join)
		end

	end

	TWO_BYTE_NEGATIVE_INT_ID = 0xfe
	TWO_BYTE_NEGATIVE_INT_LENGTH = 0x02
	class TwoByteNegativeInt < StreamObject
	
		def initialize
			super(TWO_BYTE_NEGATIVE_INT_ID, TWO_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int16.new(0)
		end

		def read(stream : Bytes)
			@data = Int16.new(stream[1, size].join)
		end

	end

	THREE_BYTE_POSITIVE_INT_ID = 0x03
	THREE_BYTE_POSITIVE_INT_LENGTH = 0x03
	class ThreeBytePositiveInt < StreamObject
	
		def initialize
			super(THREE_BYTE_POSITIVE_INT_ID, THREE_BYTE_POSITIVE_INT_LENGTH)
			@data = UInt32.new(0)
		end

		def read(stream : Bytes)
			@data = UInt32.new(stream[1, size].join)
		end

	end

	THREE_BYTE_NEGATIVE_INT_ID = 0xfd
	THREE_BYTE_NEGATIVE_INT_LENGTH = 0x03
	class ThreeByteNegativeInt < StreamObject
	
		def initialize
			super(THREE_BYTE_NEGATIVE_INT_ID, THREE_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int32.new(0)
		end

		def read(stream : Bytes)
			@data = Int32.new(stream[1, size].join)
		end

	end

	FOUR_BYTE_POSITIVE_INT_ID = 0x04
  FOUR_BYTE_POSITIVE_INT_LENGTH = 0x04
	class FourBytePositiveInt < StreamObject
	
		def initialize
			super(FOUR_BYTE_POSITIVE_INT_ID, FOUR_BYTE_POSITIVE_INT_LENGTH)
			@data = UInt32.new(0)
		end

		def read(stream : Bytes)
			@data = UInt32.new(stream[1, size].join)
		end

	end

	FOUR_BYTE_NEGATIVE_INT_ID = 0xfc
	FOUR_BYTE_NEGATIVE_INT_LENGTH = 0x04
	class FourByteNegativeInt < StreamObject
	
		def initialize
			super(FOUR_BYTE_NEGATIVE_INT_ID, FOUR_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int32.new(0)
		end

		def read(stream : Bytes)
			@data = Int32.new(stream[1, size].join)
		end

	end

	SYMBOL_ID = 0x3a0a
	class Symbol < StreamObject
	
		def initialize(stream : Bytes)
			super(SYMBOL_ID, Int32.new(stream[1]))
			@data = :nil
		end

		def read(stream : Bytes)

		end

	end

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			case stream[0]
				when 0x00
					# The value of the integer is 0. No bytes follow.
					object = ZeroByteInt.new()
				when 0x01
					# The total size of the integer is two bytes. The following byte 
					# is a positive integer in the range of 0 through 255. Only values 
					# between 123 and 255 should be represented this way to save bytes.
					object = OneBytePositiveInt.new()
				when 0xff
					# The total size of the integer is two bytes. The following byte is a negative 
					# integer in the range of -1 through -256.
					object = OneByteNegativeInt.new()
				when 0x02
					# The total size of the integer is three bytes. The following two bytes are a 
					# positive little-endian integer.
					object = TwoBytePositiveInt.new()
				when 0xfe
					# The total size of the integer is three bytes. The following two bytes are a 
					# negative little-endian integer.
					object = TwoByteNegativeInt.new()
				when 0x03
					# The total size of the integer is four bytes. The following three bytes are a 
					# positive little-endian integer.
					object = ThreeBytePositiveInt.new()
				when 0xfd
					# The total size of the integer is two bytes. The following three bytes are a 
					# negative little-endian integer.
					return ThreeByteNegativeInt.new()
				when 0x04
					# The total size of the integer is five bytes. The following four bytes are a 
					# positive little-endian integer. For compatibility with 32 bit ruby, only 
					# Fixnums less than 1073741824 should be represented this way. For sizes of 
					# stream objects full precision may be used.
					return FourBytePositiveInt.new()
				when 0xfc
					# The total size of the integer is two bytes. The following four bytes are a 
					# negative little-endian integer. For compatibility with 32 bit ruby, only 
					# Fixnums greater than -10737341824 should be represented this way. For sizes 
					# of stream objects full precision may be used.
					return FourByteNegativeInt.new()
				when ":"
					return Symbol.new(stream)
				else
					return TYPE_UNHANDLED
			end
			return object
		end

	end

	TYPE_UNHANDLED = NullStreamObject.new()

end