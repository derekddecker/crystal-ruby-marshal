require "./stream_object"
require "./integer"

module Ruby::Marshal

	class SymbolPointer < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			pointer_index = Integer.get(stream)
      super(pointer_index.size)
			@heap_index = Int32.new(pointer_index.data)
			read(stream)
		end

		def read(stream : Bytes)
			@data = Heap.get_sym(@heap_index).data
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

