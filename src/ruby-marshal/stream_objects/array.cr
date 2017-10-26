require "./stream_object"

module Ruby::Marshal

	ARRAY_ID = 0x0
	ARRAY_TYPE_IDENTIFIER = Int8.new(91) # "["

	class Array < StreamObject

		getter :data

		def initialize(stream : Bytes)
			array_length = IntegerStreamObject.get(stream)
			@num_objects = Int32.new(array_length.data)
			@data = ::Array(StreamObject).new(@num_objects)
			super(ARRAY_ID, Int32.new(array_length.size), ARRAY_TYPE_IDENTIFIER)
			stream += @size
			read(stream)
			#ObjectHeap.add(self)
		end

		def read(stream : Bytes)
			obj_index = 0
			obj_size = 0
			while(obj_index < @num_objects) 
				object = StreamObjectFactory.get(stream)
				@data << object
				obj_index += 1
				stream += object.stream_size
				@size += object.stream_size
			end
		end

	end

end
