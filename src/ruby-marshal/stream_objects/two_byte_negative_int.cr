require "./integer_stream_object"

module Ruby::Marshal

	TWO_BYTE_NEGATIVE_INT_ID = 0xfe
	TWO_BYTE_NEGATIVE_INT_LENGTH = 0x02
	class TwoByteNegativeInt < IntegerStreamObject
	
		def initialize(stream : Bytes)
			super(TWO_BYTE_NEGATIVE_INT_ID, TWO_BYTE_NEGATIVE_INT_LENGTH)
			read(stream)
		end

		def read(stream : Bytes)
			stream += 1
			data_bytes = Slice(UInt8).new(size)
			data_bytes.copy_from(stream.to_unsafe, size)
			# endian flip
			data_bytes.reverse!
			# pad + complement
			padded_slice = Slice(UInt8).new(4)
			padded_slice[2] = ~data_bytes[0]
			padded_slice[3] = ~data_bytes[1]
			@data = -(IO::ByteFormat::BigEndian.decode(Int32, padded_slice) + 1)
		end

	end

end
