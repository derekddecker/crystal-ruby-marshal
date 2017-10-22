require "./integer_stream_object"

module Ruby::Marshal

	ZERO_BYTE_INT_ID = 0x00
	ZERO_BYTE_INT_LENGTH = 0x00
	class ZeroByteInt < IntegerStreamObject

		def initialize
			super(ZERO_BYTE_INT_ID, ZERO_BYTE_INT_LENGTH)
			@data = 0x00
		end

		def read(stream : Bytes)
			# noop
			@data = 0x00
		end

	end

end
