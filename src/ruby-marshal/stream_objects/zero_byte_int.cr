require "./integer"

module Ruby::Marshal

	class ZeroByteInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
		end

		def initialize
			super(Int32.new(0x01))
		end

		def dump
			output = ::Bytes.new(2)
			output[0] = UInt8.new(Integer::TYPE_BYTE)
			output[1] = UInt8.new(0x00)
			output
		end

	end

end
