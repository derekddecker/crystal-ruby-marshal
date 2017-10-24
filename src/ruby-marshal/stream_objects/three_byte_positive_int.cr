require "./integer_stream_object"

module Ruby::Marshal

	THREE_BYTE_POSITIVE_INT_ID = 0x03
	THREE_BYTE_POSITIVE_INT_LENGTH = 0x03
	class ThreeBytePositiveInt < IntegerStreamObject
	
		def initialize
			super(THREE_BYTE_POSITIVE_INT_ID, THREE_BYTE_POSITIVE_INT_LENGTH)
			@data = Int32.new(0)
		end

		def read(stream : Bytes)
			stream += 1
			data_bytes = Slice(UInt8).new(size)
			data_bytes.copy_from(stream.to_unsafe, size)
			data_bytes.reverse!
			padded_slice = Slice(UInt8).new(4)
			padded_slice[1] = data_bytes[0]
			padded_slice[2] = data_bytes[1]
			padded_slice[3] = data_bytes[2]
			@data = ::IO::ByteFormat::BigEndian.decode(Int32, padded_slice)
		end

	end

end
