require "./stream_object"

module Ruby::Marshal

	# “o” represents an object that doesn’t have any other special 
	# form (such as a user-defined or built-in format). Following 
	# the type byte is a symbol containing the class name of the 
	# object. Following the class name is a long indicating the 
	# number of instance variable names and values for the object. 
	# Double the given number of pairs of objects follow the size.

	# The keys in the pairs must be symbols containing instance 
	# variable names.
	class ObjectObject < StreamObject

		getter :data
		@class_name : Symbol
		@num_instance_variables : IntegerStreamObject
		@instance_variables : ::Hash(::String, StreamObject)

		def initialize(stream : Bytes)
      super(0x00)
			@class_name = StreamObjectFactory.get(stream).as(Symbol)
			@data = NullStreamObject.new(stream)
			stream += @class_name.stream_size
			@num_instance_variables = IntegerStreamObject.get(stream)
			@instance_variables = ::Hash(::String, StreamObject).new
			stream += @num_instance_variables.size
			@size = @num_instance_variables.size + @class_name.stream_size
			read(stream)
			Heap.add(self)
		end

		# instantiate the class if it exists and assign to @data
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

	end

end

