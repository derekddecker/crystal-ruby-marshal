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

		getter :data, :instance_variables
		@class_name : Symbol
		@num_instance_variables : Integer
		@data : ::Hash(Hash::RawHashObjects, Hash::RawHashObjects)
		@instance_variables : Hash
		TYPE_BYTE = UInt8.new(0x6f)

		def initialize(stream : Bytes)
      super(0x00)
			@class_name = StreamObjectFactory.get(stream).as(Symbol)
			stream += @class_name.stream_size
			@instance_variables = Hash.new(stream)
			@data = @instance_variables.data
			@num_instance_variables = @instance_variables.num_keys
			@size = @instance_variables.stream_size + @class_name.stream_size - 1
			Heap.add(self)
		end

		def initialize(@num_instance_variables : Integer, @instance_variables : Hash, @class_name : Symbol)
			super(0x00)
			@data = @instance_variables.data
			@size = @num_instance_variables.stream_size + @instance_variables.stream_size - 1
			Heap.add(self)
		end

		def self.from(obj : ::Object)
			Object.new(obj.num_instance_vars, obj.instance_vars, Symbol.new(obj.class.to_s))
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

		def dump
			result = ::Bytes.new(1)
			result[0] = TYPE_BYTE
			result = result.concat(@class_name.dump)
										 .concat(@num_instance_variables.dump + 2)
										 .concat(@instance_variables.dump + 1)
		end

	end

end
