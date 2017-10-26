require "./stream_object"

module Ruby::Marshal

	SYMBOL_ID = 0x0
	SYMBOL_TYPE_IDENTIFIER = Int8.new(58) # ":"

	class Symbol < StreamObject

		getter :data
		@data = "" # : ::String
	
		def initialize(stream : Bytes)
			symbol_length = IntegerStreamObject.get(stream)
			super(SYMBOL_ID, Int32.new(symbol_length.data), SYMBOL_TYPE_IDENTIFIER)
			stream += symbol_length.size
			read(stream)
		end

		def read(stream : Bytes)
			@data = String.new(stream[0, size])
		end

	end

end
