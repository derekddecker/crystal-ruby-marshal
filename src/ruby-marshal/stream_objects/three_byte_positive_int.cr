require "./stream_object"

module Ruby::Marshal

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

end
