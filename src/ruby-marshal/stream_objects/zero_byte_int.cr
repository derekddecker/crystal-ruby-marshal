require "./integer"

module Ruby::Marshal

	class ZeroByteInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
		end

		def dump(bytestream : ::Bytes)
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
