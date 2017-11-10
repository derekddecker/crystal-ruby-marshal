require "./stream_object"

module Ruby::Marshal

	# “I” indicates that instance variables follow the next 
	# object. An object follows the type byte. Following the 
	# object is a length indicating the number of instance 
	# variables for the object. Following the length is a 
	# set of name-value pairs. The names are symbols while 
	# the values are objects. The symbols must be instance 
	# variable names (:@name).
	class InstanceObject < StreamObject

		getter :data
		@num_instance_variables : Integer
		@instance_variables : ::Hash(::String, StreamObject)

		def initialize(stream : Bytes)
      super(0x00)
			@data = StreamObjectFactory.get(stream)
			stream += 1 + @data.as(Ruby::Marshal::StreamObject).stream_size
			@num_instance_variables = Integer.get(stream)
			@instance_variables = ::Hash(::String, StreamObject).new
			@size = 1 + @data.as(Ruby::Marshal::StreamObject).stream_size + @num_instance_variables.size
			stream += @num_instance_variables.size
			read(stream)
			Heap.add(self)
		end

		# read instance variables
		def read(stream : Bytes)
			i = 0
			while(i < @num_instance_variables.data)
				instance_var_name = StreamObjectFactory.get(stream)
				stream += instance_var_name.stream_size
				@size += instance_var_name.stream_size
				instance_var_value = StreamObjectFactory.get(stream)
				stream += instance_var_value.stream_size
				@size += instance_var_value.stream_size
				@instance_variables[instance_var_name.data.as(::String)] = instance_var_value
				i += 1
			end
		end

		def data
			@data.data
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

