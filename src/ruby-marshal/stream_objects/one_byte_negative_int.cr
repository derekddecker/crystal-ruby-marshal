require "./stream_object"

module Ruby::Marshal

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

end
