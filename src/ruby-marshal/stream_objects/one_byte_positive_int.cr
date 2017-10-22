require "./stream_object"

module Ruby::Marshal

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

end
