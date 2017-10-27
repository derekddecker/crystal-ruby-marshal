require "./stream_object"

module Ruby::Marshal

	OBJECT_POINTER_TYPE_IDENTIFIER = Int8.new(64) # ";"

	class ObjectPointer < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			pointer_index = IntegerStreamObject.get(stream)
      super(0x00, pointer_index.stream_size, STRING_POINTER_TYPE_IDENTIFIER)
			@heap_index = Int32.new(pointer_index.data)
			puts "pointer index size: #{pointer_index}"
			read(stream)
		end

		def read(stream : Bytes)
			@data = Heap.get_obj(@heap_index).data
		end

		def stream_size
			# 1 for the 8 bit identifier ";"
			puts "symbol pointer size: #{size}"
			return size
		end

	end

end
