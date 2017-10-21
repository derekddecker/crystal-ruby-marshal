module Ruby::Marshal

	class StreamObjectMeta

		getter :object_id, :object_size

		def initialize(@object_id : Int32, @object_size : Int32)
		end

	end

	class StreamObjectMetaFactory

		def self.get(object_id : UInt8)
			case object_id
				when 0x00
					return TYPE_ZERO_BYTE_INT
				when 0x01
					return TYPE_ONE_BYTE_POSITIVE_INT
				when 0xff
					return TYPE_ONE_BYTE_NEGATIVE_INT
				when 0x02
					return TYPE_TWO_BYTE_POSITIVE_INT
				when 0xfe
					return TYPE_TWO_BYTE_NEGATIVE_INT
				when 0x03
					return TYPE_THREE_BYTE_POSITIVE_INT
				when 0xfd
					return TYPE_THREE_BYTE_NEGATIVE_INT
				when 0x04
					return TYPE_FOUR_BYTE_POSITIVE_INT
				when 0xfc
					return TYPE_FOUR_BYTE_NEGATIVE_INT
				else
					return TYPE_UNHANDLED
			end
		end

	end

	# The value of the integer is 0. No bytes follow.
	TYPE_ZERO_BYTE_INT = StreamObjectMeta.new(0x00, 0x00)

	# The total size of the integer is two bytes. The following byte is a positive 
	# integer in the range of 0 through 255. Only values between 123 and 255 should 
	# be represented this way to save bytes.
	TYPE_ONE_BYTE_POSITIVE_INT = StreamObjectMeta.new(0x01, 0x01)

	# The total size of the integer is two bytes. The following byte is a negative 
	# integer in the range of -1 through -256.
	TYPE_ONE_BYTE_NEGATIVE_INT = StreamObjectMeta.new(0xff, 0x01)

	# The total size of the integer is three bytes. The following two bytes are a 
	# positive little-endian integer.
	TYPE_TWO_BYTE_POSITIVE_INT = StreamObjectMeta.new(0x02, 0x02)

	# The total size of the integer is three bytes. The following two bytes are a 
	# negative little-endian integer.
	TYPE_TWO_BYTE_NEGATIVE_INT= StreamObjectMeta.new(0xfe, 0x02)

	# The total size of the integer is four bytes. The following three bytes are a 
	# positive little-endian integer.
	TYPE_THREE_BYTE_POSITIVE_INT = StreamObjectMeta.new(0x03, 0x03)

	# The total size of the integer is two bytes. The following three bytes are a 
	# negative little-endian integer.
	TYPE_THREE_BYTE_NEGATIVE_INT = StreamObjectMeta.new(0xfd, 0x03)

	# The total size of the integer is five bytes. The following four bytes are a 
	# positive little-endian integer. For compatibility with 32 bit ruby, only 
	# Fixnums less than 1073741824 should be represented this way. For sizes of 
	# stream objects full precision may be used.
	TYPE_FOUR_BYTE_POSITIVE_INT = StreamObjectMeta.new(0x04, 0x04)

	# The total size of the integer is two bytes. The following four bytes are a 
	# negative little-endian integer. For compatibility with 32 bit ruby, only 
	# Fixnums greater than -10737341824 should be represented this way. For sizes 
	# of stream objects full precision may be used.
	TYPE_FOUR_BYTE_NEGATIVE_INT = StreamObjectMeta.new(0xfc, 0x04)

	TYPE_UNHANDLED = StreamObjectMeta.new(0x00, 0x00)

end