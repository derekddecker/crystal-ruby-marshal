require "./stream_object"

module Ruby::Marshal

	FOUR_BYTE_POSITIVE_INT_ID = 0x04
  FOUR_BYTE_POSITIVE_INT_LENGTH = 0x04
	class FourBytePositiveInt < StreamObject
	
		def initialize
			super(FOUR_BYTE_POSITIVE_INT_ID, FOUR_BYTE_POSITIVE_INT_LENGTH)
			@data = UInt32.new(0)
		end

		def read(stream : Bytes)
			@data = ::IO::ByteFormat::LittleEndian.decode(UInt32, stream[1, size])
		end

	end

end
