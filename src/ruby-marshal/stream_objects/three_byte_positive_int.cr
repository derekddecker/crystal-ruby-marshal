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
			data_bytes = stream[1, size]
			padded_slice = Slice(UInt8).new(4)
			padded_slice.copy_from(data_bytes.to_unsafe, size)
			padded_slice[0] = UInt8.new(0x00)
			@data = ::IO::ByteFormat::LittleEndian.decode(Int32, padded_slice)
		end

	end

end
