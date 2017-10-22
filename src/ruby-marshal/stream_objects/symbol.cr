require "./stream_object"

module Ruby::Marshal

	SYMBOL_ID = 0x3a0a
	SYMBOL_TYPE_IDENTIFIER = Int8.new(58) # ":"

	class Symbol < StreamObject
	
		def initialize(@size : Int32)
			super(SYMBOL_ID, @size, SYMBOL_TYPE_IDENTIFIER)
			@data = :nil
		end

		def read(stream : Bytes)

		end

	end

end
