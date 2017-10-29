require "./stream_object"
require "./array"
require "./object_pointer"

module Ruby::Marshal

	# “{” represents a Hash object while “}” represents a Hash 
	# with a default value set (Hash.new 0). Following the type 
	# byte is a long indicating the number of key-value pairs 
	# in the Hash, the size. Double the given number of objects 
	# follow the size.

	# For a Hash with a default value, the default value follows 
	# all the pairs.
	class Hash < StreamObject
		
    alias RawHashObjects = StreamObject | ::Bool | ::Int32 | ::String | ::Nil | ::Array(Ruby::Marshal::Array::RubyStreamArray) | ::Hash(Ruby::Marshal::StreamObject, Ruby::Marshal::StreamObject) | ::Float64 | ::Hash(RawHashObjects, RawHashObjects)

		getter :data, :default_value
		@data : ::Hash(StreamObject, StreamObject)
		@num_keys : Integer
		@default_value : StreamObject | Null

		def initialize(stream : Bytes)
			@default_value = Null.new
			@num_keys = Integer.get(stream)
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
			return stream
		end

		def each(&block)
			@data.each do |kv|
				yield kv
			end
		end

		macro add_hash_accessor(klass)
			def [](requested_key : {{klass}})
				result = Null.new
				@data.each do |(k, v)|
					if(k.data.class == {{klass}})
						if k.data.as({{klass}}) == requested_key
							result = v 
							break
						 end
					end
				end
				return result
			end
		end

		add_hash_accessor ::String
		add_hash_accessor ::Int32

		def raw_hash : ::Hash(RawHashObjects, RawHashObjects)
			unless @default_value.data.nil?
				raw_hash = ::Hash(RawHashObjects, RawHashObjects).new { @default_value.data }
			else
				raw_hash = ::Hash(RawHashObjects, RawHashObjects).new 
			end
			@data.each do |(k, v)|
				key = (k.class == Ruby::Marshal::Hash) ? k.as(Hash).raw_hash : k.data
				value = (v.class == Ruby::Marshal::Hash) ? v.as(Hash).raw_hash : v.data
				raw_hash[key] = value
			end
			raw_hash
		end

	end

end

