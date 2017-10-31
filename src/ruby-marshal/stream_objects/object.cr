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
		@instance_variables : ::Hash(::String, StreamObject)

		def initialize(stream : Bytes)
      super(0x00)
			@class_name = StreamObjectFactory.get(stream).as(Symbol)
			@data = Null.new(stream)
			stream += @class_name.stream_size
			@num_instance_variables = Integer.get(stream)
			@instance_variables = ::Hash(::String, StreamObject).new
			stream += @num_instance_variables.size
			@size = @num_instance_variables.size + @class_name.stream_size
			read(stream)
			Heap.add(self)
		end

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
			return stream
		end

		def populate_class(klass : ::Object)
			klass.new(self)
		end

		def read_attr(name : ::String, raw = false)
			key = @instance_variables.has_key?(name) ? name : "@#{name}"
			attr = @instance_variables.has_key?(key) ? @instance_variables[key] : nil
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

	end

end

macro ruby_marshal_properties(prop_hash)

	{% for prop, klass in prop_hash %}
		@{{ prop.id }} : {{ klass }}
	
		def read_ruby_marshalled_{{ prop.id }}(marshalled_object : ::Ruby::Marshal::Object) : {{klass}} 
			marshalled_object.read_raw_attr("{{ prop.id }}").as({{ klass }})
		end
	{% end %}

	def initialize(marshalled_object : ::Ruby::Marshal::StreamObject)
		marshalled_object = marshalled_object.as(::Ruby::Marshal::Object)
		{% for prop, klass in prop_hash %}
			@{{ prop.id }} = read_ruby_marshalled_{{ prop.id }}(marshalled_object).as({{ klass }})
		{% end %}
	end

end
