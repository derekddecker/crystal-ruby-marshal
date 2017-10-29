require "./stream_object"
require "./array"

module Ruby::Marshal

	# “{” represents a Hash object while “}” represents a Hash 
	# with a default value set (Hash.new 0). Following the type 
	# byte is a long indicating the number of key-value pairs 
	# in the Hash, the size. Double the given number of objects 
	# follow the size.

	# For a Hash with a default value, the default value follows 
	# all the pairs.
	class Hash < StreamObject

		getter :data
		@data : ::Hash(StreamObject, StreamObject)
		@num_keys : IntegerStreamObject

		def initialize(stream : Bytes)
			@num_keys = IntegerStreamObject.get(stream)
			@data = ::Hash(StreamObject, StreamObject).new
			stream += @num_keys.size
			super(@num_keys.size)
			read(stream)
			Heap.add(self)
		end

		# instantiate the class if it exists and assign to @data
		def read(stream : Bytes)
			i = 0
			while(i < @num_keys.data)
				instance_var_name = StreamObjectFactory.get(stream)
				stream += instance_var_name.stream_size
				@size += instance_var_name.stream_size
				instance_var_value = StreamObjectFactory.get(stream)
				stream += instance_var_value.stream_size
				@size += instance_var_value.stream_size
				@data[instance_var_name] = instance_var_value
				i += 1
			end
		end

		def [](requested_key : ::String)
			result = NullStreamObject.new
			@data.each do |(k, v)| 
				if k.data.as(::String) == requested_key
					result = v 
					break
				 end
			end
			return result
		end

	end

end

