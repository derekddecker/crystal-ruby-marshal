require "./stream_object"

module Ruby::Marshal

	# “S” represents a Struct. Following the type byte is a 
	# symbol containing the name of the struct. Following 
	# the name is a long indicating the number of members 
	# in the struct. Double the number of objects follow the 
	# member count. Each member is a pair containing the 
	# member’s symbol and an object for the value of that 
	# member.
	# 
	# If the struct name does not match a Struct subclass in 
	# the running ruby an exception should be raised.
	#
	# If there is a mismatch between the struct in the 
	# currently running ruby and the member count in the 
	# marshaled struct an exception should be raised.
	class Struct < StreamObject

		getter :data
		@struct_name : Symbol
		@num_members : Integer
		@members : ::Hash(::String, StreamObject)
		TYPE_BYTE = UInt8.new(0x53)

		def initialize(stream : Bytes)
      super(0x00)
			@data = Null.new
			@struct_name = StreamObjectFactory.get(stream).as(Symbol)
			stream += @struct_name.stream_size
			@num_members = Integer.get(stream)
			@members = ::Hash(::String, StreamObject).new
			stream += @num_members.size
			@size = @num_members.size + @struct_name.stream_size
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			i = 0
			while(i < @num_members.data)
				instance_var_name = StreamObjectFactory.get(stream)
				stream += instance_var_name.stream_size
				@size += instance_var_name.stream_size
				instance_var_value = StreamObjectFactory.get(stream)
				stream += instance_var_value.stream_size
				@size += instance_var_value.stream_size
				@members[instance_var_name.data.as(::String)] = instance_var_value
				i += 1
			end
		end

		def populate_class(klass : ::Object)
			klass.new(self)
		end

		def read_attr(name : ::String, raw = false)
			key = @members.has_key?(name) ? name : "@#{name}"
			attr = @members.has_key?(key) ? @members[key] : nil
			if(raw && !attr.nil?) 
				if (attr.is_a?(::Hash))
					return attr.raw_hash
				else
					return attr.data 
				end
			else
				return attr
			end
		end
		
		def read_raw_attr(name : ::String)
			read_attr(name, true)
		end

		def initialize(str : ::Struct)
			@size = 0
      super(@size)
			@data = Null.new
			@num_members = str.num_instance_vars
			@members = str.instance_vars
			@struct_name = Symbol.new(str.class.to_s)
		end

		def dump
			output = ::Bytes.new(1) 
			output[0] = TYPE_BYTE
			output = output.concat(@struct_name.dump)
										 .concat(@num_members.dump)
			#							 .concat(@members.dump)
		end

	end

end
