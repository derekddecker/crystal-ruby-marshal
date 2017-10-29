require "./stream_object"

module Ruby::Marshal

	class Array < StreamObject

		getter :data
    alias RubyStreamArray = StreamObject | ::Float64 | ::Bool | ::Int32 | ::String | ::Nil | ::Array(RubyStreamArray) | ::Hash(StreamObject, StreamObject)
    @data : RubyStreamArray
    @num_objects : Int32

		def initialize(stream : Bytes)
			array_length = Integer.get(stream)
      @num_objects = array_length.data
      @data = ::Array(RubyStreamArray).new(@num_objects)
			super(array_length.size)
			stream += @size
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			obj_index = 0
			obj_size = 0
			while(obj_index < @num_objects)
				object = StreamObjectFactory.get(stream)
        @data.as(::Array(RubyStreamArray)) << object.data
				obj_index += 1
				stream += object.stream_size
				@size += object.stream_size
			end
		end

	end

end

