require "./stream_object"

module Ruby::Marshal

	class Null < StreamObject

		getter :data
    @data : ::Nil
		@type_byte = UInt8.new(0x30)

		def initialize(stream : Bytes)
      super(Int32.new(0x00))
			@data = nil
		end

		def initialize
      super(Int32.new(0x00))
			@data = nil
		end

		def dump
			output = ::Bytes.new(1) 
			output[0] = @type_byte
			output
		end

	end

end

