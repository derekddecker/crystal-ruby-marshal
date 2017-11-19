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
	class Object < StreamObject

		getter :data
		@class_name : Symbol
		@num_instance_variables : Integer
		@instance_variables : Hash

		def initialize(stream : Bytes)
      super(0x00)
			@class_name = StreamObjectFactory.get(stream).as(Symbol)
			@data = Null.new(stream)
			stream += @class_name.stream_size
			@instance_variables = Hash.new(stream)
			@num_instance_variables = @instance_variables.num_keys
			@size = @instance_variables.stream_size + @class_name.stream_size - 1
			Heap.add(self)
		end

		def populate_class(klass : ::Object)
			klass.new(self)
		end

		def read_attr(name : ::String, raw = false)
			key = @instance_variables.raw_hash.has_key?(name) ? name : "@#{name}"
			attr = @instance_variables.raw_hash.has_key?(key) ? @instance_variables[key] : nil
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

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
