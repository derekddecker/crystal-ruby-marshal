require "./integer_stream_object"

module Ruby::Marshal

	ONE_BYTE_INT_ID = 0x00
	ONE_BYTE_INT_LENGTH = 0x01
	class OneByteInt < IntegerStreamObject

		def initialize
			super(ONE_BYTE_INT_ID, ONE_BYTE_INT_LENGTH)
			@data = Int8.new(0)
		end

		def read(stream : Bytes)
			@data = Int8.new(stream[0])
		end

	end

end
