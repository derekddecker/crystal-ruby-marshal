require "./stream_object"

module Ruby::Marshal

	# “c” represents a Class object, “m” represents a Module 
	# and “M” represents either a class or module (this is an 
	# old-style for compatibility). No class or module content 
	# is included, this type is only a reference. Following 
	# the type byte is a byte sequence which is used to look 
	# up an existing class or module, respectively.
	# 
	# Instance variables are not allowed on a class or module.
	# 
	#	If no class or module exists an exception should be raised.
	#
	#	For “c” and “m” types, the loaded object must be a class 
	# or module, respectively.
	class Module < StreamObject

		getter :data
    @data : ::String
		@length : Integer

		def initialize(stream : Bytes)
			@data = ""
			@length = Integer.get(stream)
      super(@length.size)
			stream += @length.size
			read(stream)
		end

		def read(stream : Bytes)
			# noop
			@data = ::String.new(stream[0, @length.data])
			@size += @length.data
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

