require "./integer"

module Ruby::Marshal

	class OneBytePositiveInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			read(stream)
		end

		def read(stream : Bytes)
			@data = Int32.new(stream[1, size].join)
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
