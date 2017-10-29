require "./integer"

module Ruby::Marshal

	class OneByteNegativeInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			read(stream)
		end

		def read(stream : Bytes)
			data_bytes = stream[1, size]
			complement_slice = Slice(UInt8).new(size)
			data_bytes.each_with_index { |byte, index| complement_slice[index] = ~byte }
			@data = -(Int32.new(complement_slice.join) + 1)
		end

	end

end
