require "./stream_object"
require "./array"

module Ruby::Marshal

	class ObjectPointer < StreamObject

    alias RubyStreamObjects = StreamObject | ::Bytes | ::Regex | ::Bool | ::Int32 | ::String | ::Nil | ::Array(Ruby::Marshal::Array::RubyStreamArray) | ::Hash(Ruby::Marshal::StreamObject, Ruby::Marshal::StreamObject) | ::Float64 
    @data : RubyStreamObjects
		getter :data

		def initialize(stream : Bytes)
			@data = ""
			pointer_index = Integer.get(stream)
      super(pointer_index.stream_size)
			@heap_index = Int32.new(pointer_index.data)
			read(stream)
		end

		def read(stream : Bytes)
			@data = Heap.get_obj(@heap_index).data
		end

	end

end

