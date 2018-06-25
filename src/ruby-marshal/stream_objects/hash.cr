require "./stream_object"
require "./array"
require "../hash"
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
		
    alias RawHashObjects = ::Symbol | ::Float64 | ::Regex | ::Bytes | ::Bool | ::Int32 | ::String | ::Nil | ::Array(RawHashObjects) |  ::Hash(RawHashObjects, RawHashObjects)

		getter :data, :default_value, :num_keys
		@data : ::Hash(RawHashObjects, RawHashObjects) # RawHashObjects # ::Hash(StreamObject, StreamObject)
		@num_keys : Integer
		@default_value : RawHashObjects
		TYPE_BYTE = UInt8.new(0x7b)

		def initialize(stream : Bytes)
			@size = 0
			@default_value = nil
			@num_keys = Integer.get(stream)
			@data = ::Hash(RawHashObjects, RawHashObjects).new
			stream += @num_keys.size
			super(@num_keys.size)
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			i = 0
			while(i < @num_keys.data)
				instance_var_name = StreamObjectFactory.get(stream)
				stream += instance_var_name.stream_size
				@size += instance_var_name.stream_size
				instance_var_value = StreamObjectFactory.get(stream)
				stream += instance_var_value.stream_size
				@size += instance_var_value.stream_size
				@data[instance_var_name.data] = instance_var_value.data
				i += 1
			end
			stream
		end

		def initialize(hash : ::Hash(RawHashObjects, RawHashObjects))
			@size = 0
			@default_value = nil
			@data = ::Hash(RawHashObjects, RawHashObjects).new
			@num_keys = Integer.get(hash.keys.size)
			super(@num_keys.size)
			hash.each do |key, value|
				instance_var_name = key.ruby_marshal_dump
				@size += instance_var_name.stream_size
				instance_var_value = value.ruby_marshal_dump
				@size += instance_var_value.stream_size
				@data[instance_var_name.data] = instance_var_value.data
			end
		end

		def each(&block)
			@data.each do |kv|
				yield kv
			end
		end

		macro add_hash_accessor(klass)
			def [](requested_key : {{klass}})
				result = nil
				@data.each do |(k, v)|
					if(k.class == {{klass}})
						if k.as({{klass}}) == requested_key
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

		def dump
			output = ::Bytes.new(1) 
			output[0] = TYPE_BYTE
			output = output.concat(@num_keys.dump + 1)
			null = Null.new
			@data.each do |(key, value)|
				output = output.concat(key.ruby_marshal_dump.dump || null.dump)
				output = output.concat(value.ruby_marshal_dump.dump || null.dump)
			end
			output
		end

	end

end

