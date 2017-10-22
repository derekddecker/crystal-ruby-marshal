require "./stream_object"

module Ruby::Marshal

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

end
