require "./stream_object"

module Ruby::Marshal

	class False < StreamObject

		@data : Bool
		@type_byte = UInt8.new(0x46)
		getter :data

		def initialize(stream : Bytes)
			super(Int32.new(0x00))
			@data = false
		end

		def initialize(bool : ::Bool)
			super(0x00)
			@data = false
		end

		def dump
			output = ::Bytes.new(1) 
			output[0] = @type_byte
			output
		end

	end

end

