require "./integer_stream_object"

module Ruby::Marshal

	THREE_BYTE_POSITIVE_INT_ID = 0x03
	THREE_BYTE_POSITIVE_INT_LENGTH = 0x03
	class ThreeBytePositiveInt < IntegerStreamObject
	
		def initialize
			super(THREE_BYTE_POSITIVE_INT_ID, THREE_BYTE_POSITIVE_INT_LENGTH)
			@data = UInt32.new(0)
		end

		def read(stream : Bytes)
			@data = ::IO::ByteFormat::LittleEndian.decode(UInt32, stream[1, size])
		end

	end

end
