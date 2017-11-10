require "./stream_object"
require "./integer"

module Ruby::Marshal

	class Symbol < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			symbol_length = Integer.get(stream)
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

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

