require "./integer_stream_object"

module Ruby::Marshal

	FOUR_BYTE_NEGATIVE_INT_ID = 0xfc
	FOUR_BYTE_NEGATIVE_INT_LENGTH = 0x04
	class FourByteNegativeInt < IntegerStreamObject
	
		def initialize
			super(FOUR_BYTE_NEGATIVE_INT_ID, FOUR_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int32.new(0)
		end

		def read(stream : Bytes)
			stream += 1
			data_bytes = Slice(UInt8).new(size)
			data_bytes.copy_from(stream.to_unsafe, size)
			# endian flip
			data_bytes.reverse!
			# pad + complement
			padded_slice = Slice(UInt8).new(4)
			padded_slice[0] = ~data_bytes[0]
			padded_slice[1] = ~data_bytes[1]
			padded_slice[2] = ~data_bytes[2]
			padded_slice[3] = ~data_bytes[3]
			@data = -(IO::ByteFormat::BigEndian.decode(Int32, padded_slice) + 1)
		end

	end

end
