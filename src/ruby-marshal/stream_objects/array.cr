require "./stream_object"

module Ruby::Marshal

	ARRAY_ID = 0x0
	ARRAY_TYPE_IDENTIFIER = Int8.new(91) # "["

	class Array < StreamObject

		getter :data
    alias RubyStreamArray = ::Bool | ::Int32 | ::String | ::Nil | ::Array(RubyStreamArray)
    @data : RubyStreamArray
    @num_objects : Int32

		def initialize(stream : Bytes)
			array_length = IntegerStreamObject.get(stream)
      @num_objects = array_length.data
      @data = ::Array(RubyStreamArray).new(@num_objects)
			super(ARRAY_ID, array_length.size, ARRAY_TYPE_IDENTIFIER)
			stream += @size
			read(stream)
			#ObjectHeap.add(self)
		end

		def read(stream : Bytes)
			obj_index = 0
			obj_size = 0
			while(obj_index < @num_objects)
				puts stream.hexdump
				object = StreamObjectFactory.get(stream)
        puts object.data.inspect
        @data.as(::Array(RubyStreamArray)) << object.data
				obj_index += 1
				stream += object.stream_size
				@size += object.stream_size
			end
		end

		def stream_size
			return 1 + @size
		end

	end

end
