require "./stream_object"

module Ruby::Marshal

	class SymbolPointer < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			pointer_index = IntegerStreamObject.get(stream)
      super(pointer_index.size)
			@heap_index = Int32.new(pointer_index.data)
			read(stream)
		end

		def read(stream : Bytes)
			@data = Heap.get_sym(@heap_index).data
		end

	end

end

