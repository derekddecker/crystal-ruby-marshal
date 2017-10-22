require "./stream_object"

module Ruby::Marshal

	SYMBOL_ID = 0x3a0a
	class Symbol < StreamObject
	
		def initialize(stream : Bytes)
			super(SYMBOL_ID, Int32.new(stream[1]))
			@data = :nil
		end

		def read(stream : Bytes)

		end

	end

end
