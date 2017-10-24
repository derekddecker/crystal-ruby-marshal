require "./integer_stream_object"

module Ruby::Marshal

	TWO_BYTE_POSITIVE_INT_ID = 0x02
	TWO_BYTE_POSITIVE_INT_LENGTH = 0x02
	class TwoBytePositiveInt < IntegerStreamObject
	
		def initialize
			super(TWO_BYTE_POSITIVE_INT_ID, TWO_BYTE_POSITIVE_INT_LENGTH)
			@data = Int16.new(0)
		end

		def read(stream : Bytes)
			@data = ::IO::ByteFormat::LittleEndian.decode(UInt16, stream[1, size])
		end

	end

end
