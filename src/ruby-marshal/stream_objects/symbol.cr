require "./stream_object"

module Ruby::Marshal

	SYMBOL_ID = 0x0
	SYMBOL_TYPE_IDENTIFIER = Int8.new(58) # ":"

	class Symbol < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			symbol_length = IntegerStreamObject.get(stream)
      super(SYMBOL_ID, symbol_length.data, SYMBOL_TYPE_IDENTIFIER)
			stream += symbol_length.size
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			@data = String.new(stream[0, size])
		end

	end

	SYMBOL_POINTER_TYPE_IDENTIFIER = Int8.new(59) # ";"

	class SymbolPointer < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			pointer_index = IntegerStreamObject.get(stream)
      super(SYMBOL_ID, pointer_index.data, SYMBOL_POINTER_TYPE_IDENTIFIER)
			stream += pointer_index.size
			read(stream)
		end

		def read(stream : Bytes)
			@data = Heap.get_sym(size).data
		end

		def stream_size
			# 1 for the 8 bit identifier ";"
			return (1 + size)
		end

	end

end
