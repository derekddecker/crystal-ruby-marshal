require "./stream_object"

module Ruby::Marshal

	class Array < StreamObject

		getter :data
    alias RubyStreamArray = StreamObject | ::Regex | ::Bytes | ::Float64 | ::Bool | ::Int32 | ::String | ::Nil | ::Array(RubyStreamArray) | ::Hash(StreamObject, StreamObject)
    @data : RubyStreamArray
    @num_objects : Int32
		TYPE_BYTE = ::UInt8.new(0x5b)

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
			while(obj_index < @num_objects)
				object = StreamObjectFactory.get(stream)
        @data.as(::Array(RubyStreamArray)) << object.data
				obj_index += 1
				stream += object.stream_size
				@size += object.stream_size
			end
		end

		def initialize(array : ::Array)
			obj_count = Integer.get(array.size)
			@num_objects = obj_count.data
			@data = ::Array(RubyStreamArray).new(@num_objects)
			s = obj_count.size
			obj_index = 0
			while(obj_index < @num_objects)
				object = StreamObjectFactory.from(array[obj_index])
        @data.as(::Array(RubyStreamArray)) << object
				obj_index += 1
				s += object.stream_size
			end
			super(s)
		end

		def dump
			result = ::Bytes.new(1)
			result[0] = TYPE_BYTE
			result = result.concat(Integer.get(@num_objects).dump + 1)
			obj_index = 0
			while(obj_index < @num_objects)
				dumped_obj = @data.as(::Array(RubyStreamArray))[obj_index].as(StreamObject).dump || ::Bytes.new(0)
				result = result.concat(dumped_obj)
				obj_index += 1
			end
			result
		end

	end

end

