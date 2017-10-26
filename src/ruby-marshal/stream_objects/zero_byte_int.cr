require "./integer_stream_object"

module Ruby::Marshal

	ZERO_BYTE_INT_ID = 0x00
  ZERO_BYTE_INT_LENGTH = Int32.new(0x00)
	class ZeroByteInt < IntegerStreamObject

		def initialize(stream : Bytes)
			super(ZERO_BYTE_INT_ID, ZERO_BYTE_INT_LENGTH)
			read(stream)
		end

		def read(stream : Bytes)
			# noop
		end

	end

end
