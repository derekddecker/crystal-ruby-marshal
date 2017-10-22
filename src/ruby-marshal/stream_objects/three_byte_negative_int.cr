require "./stream_object"

module Ruby::Marshal

	THREE_BYTE_NEGATIVE_INT_ID = 0xfd
	THREE_BYTE_NEGATIVE_INT_LENGTH = 0x03
	class ThreeByteNegativeInt < StreamObject
	
		def initialize
			super(THREE_BYTE_NEGATIVE_INT_ID, THREE_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int32.new(0)
		end

		def read(stream : Bytes)
			@data = ::IO::ByteFormat::LittleEndian.decode(Int32, stream[1, size])
		end

	end

end
