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

		getter :data, :instance_variables
		@struct_name : Symbol
		@data : ::Hash(Hash::RawHashObjects, Hash::RawHashObjects)
		@num_members : Integer
		@instance_variables : Hash
		TYPE_BYTE = UInt8.new(0x53)

		def initialize(stream : Bytes)
      super(0x00)
			@struct_name = StreamObjectFactory.get(stream).as(Symbol)
			stream += @struct_name.stream_size
			@instance_variables = Hash.new(stream)
			@data = @instance_variables.data
			@num_members = @instance_variables.num_keys
			@size = @instance_variables.size + @struct_name.stream_size - 1
			Heap.add(self)
		end

		def populate_class(klass : ::Object)
			klass.new(self)
		end

		def read_attr(name : ::String, raw = false)
			key = @data.has_key?(name) ? name : "@#{name}"
			@data.has_key?(key) ? @data[key] : nil
		end
		
		def read_raw_attr(name : ::String)
			read_attr(name, true)
		end

		def initialize(str : ::Struct)
			@size = 0
      super(@size)
			@num_members = str.num_instance_vars
			@instance_variables = str.instance_vars
			@data = @instance_variables.data
			@struct_name = Symbol.new(str.class.to_s)
		end

		def dump
			output = ::Bytes.new(1) 
			output[0] = TYPE_BYTE
			output = output.concat(@struct_name.dump)
										 .concat(@num_members.dump + 2)
										 .concat(@instance_variables.dump + 1)
		end

	end

end
