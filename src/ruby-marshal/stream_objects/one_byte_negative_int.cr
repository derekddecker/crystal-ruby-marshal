require "./stream_object"

module Ruby::Marshal

	ONE_BYTE_NEGATIVE_INT_ID = 0xff
	ONE_BYTE_NEGATIVE_INT_LENGTH = 0x01
	class OneByteNegativeInt < StreamObject
	
		def initialize
			super(ONE_BYTE_NEGATIVE_INT_ID, ONE_BYTE_NEGATIVE_INT_LENGTH)
			@data = Int16.new(0)
		end

		def read(stream : Bytes)
			data_bytes = stream[1, size]
			complement_slice = Slice(UInt8).new(size)
			data_bytes.each_with_index { |byte, index| complement_slice[index] = ~byte }
			@data = -(Int16.new(complement_slice.join) + 1)
		end

	end

end
