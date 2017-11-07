require "./stream_object"

module Ruby::Marshal

	class True < StreamObject

		@data : Bool
		@type_byte = UInt8.new(0x54)
		getter :data

		def initialize(stream : Bytes)
			super(Int32.new(0x00))
			@data = true
		end

		def initialize(bool : ::Bool)
			super(0x00)
			@data = true
		end

		def dump(bytestream : ::Bytes)
			output = ::Bytes.new(1) 
			output[0] = @type_byte
			bytestream.concat(output)
		end

	end

end

