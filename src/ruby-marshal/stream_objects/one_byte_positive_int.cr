require "./integer"

module Ruby::Marshal

	class OneBytePositiveInt < Integer

		SUB_TYPE_BYTE = UInt8.new(0x01)

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			@data = Int32.new(stream[1, size].join)
		end

		def initialize(int : ::Int32)
			super(Int32.new(0x01))
			@data = int
		end

		def dump
			output = ::Bytes.new(3)
			output[0] = UInt8.new(Integer::TYPE_BYTE)
			output[1] = UInt8.new(SUB_TYPE_BYTE)
			output[2] = UInt8.new(@data)
			output
		end

	end

end
