require "./integer_stream_object"

module Ruby::Marshal

	TWO_BYTE_POSITIVE_INT_ID = 0x02
  TWO_BYTE_POSITIVE_INT_LENGTH = Int32.new(0x02)
	class TwoBytePositiveInt < IntegerStreamObject

		def initialize(stream : Bytes)
			super(TWO_BYTE_POSITIVE_INT_ID, TWO_BYTE_POSITIVE_INT_LENGTH)
			read(stream)
		end

		def read(stream : Bytes)
			@data = Int32.new(::IO::ByteFormat::LittleEndian.decode(UInt16, stream[1, size]))
		end

	end

end
