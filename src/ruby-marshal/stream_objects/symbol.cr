require "./stream_object"

module Ruby::Marshal

	class Symbol < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			symbol_length = IntegerStreamObject.get(stream)
			@symbol_length = symbol_length.size.as(Int32)
      super(symbol_length.data)
			stream += @symbol_length
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			@data = ::String.new(stream[0, size])
		end

		def stream_size
			1 + @symbol_length + size
		end

	end

end

