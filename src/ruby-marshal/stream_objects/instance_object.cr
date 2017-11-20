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
		@instance_variables : Hash

		def initialize(stream : Bytes)
      super(0x00)
			@data = StreamObjectFactory.get(stream)
			stream += @data.stream_size
			@instance_variables = Hash.new(stream)
			@num_instance_variables = @instance_variables.num_keys
			@size = @instance_variables.stream_size + @data.stream_size - 1
			Heap.add(self)
		end

		def initialize(num_vars : Integer, vars : Hash)
			super(0x00)
			@num_instance_variables = num_vars
			@instance_variables = vars
			@data = vars.dump
			@size = @num_instance_variables.stream_size + @instance_variables.stream_size - 1
		end

		def self.from(obj : ::Object)
			InstanceObject.new(obj.num_instance_vars, obj.instance_vars)
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

