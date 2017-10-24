require "./stream_object"

module Ruby::Marshal

	SYMBOL_ID = 0x0
	SYMBOL_TYPE_IDENTIFIER = Int8.new(58) # ":"

	class Symbol < StreamObject

		getter :data
		@data : ::String
	
		def initialize(@size : Int32)
			super(SYMBOL_ID, @size, SYMBOL_TYPE_IDENTIFIER)
			@data = ""
		end

		def read(stream : Bytes)
			@data = String.new(stream[0, size])
		end

	end

end
