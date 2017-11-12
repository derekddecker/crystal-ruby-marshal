require "./integer"

module Ruby::Marshal

	class OneByteNegativeInt < Integer

		SUB_TYPE_BYTE = UInt8.new(0xff)

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			data_bytes = stream[1, size]
			complement_slice = Slice(UInt8).new(size)
			data_bytes.each_with_index { |byte, index| complement_slice[index] = ~byte }
			@data = -(Int32.new(complement_slice.join) + 1)
		end

		def initialize(int : ::Int32)
			super(Int32.new(0x01))
			@data = int
		end

		def dump
			output = ::Bytes.new(3)
			output[0] = UInt8.new(Integer::TYPE_BYTE)
			output[1] = UInt8.new(SUB_TYPE_BYTE)
			output[2] = ~UInt8.new(-@data - 1)
			output
		end

	end

end
