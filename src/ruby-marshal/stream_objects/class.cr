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
	class Class < StreamObject

		getter :data
    @data : ::String
		@byte_sequence : ByteSequence
		@type_byte = UInt8.new(0x63)

		def initialize(stream : Bytes)
			@byte_sequence = ByteSequence.new(stream)
			@data = ::String.new(@byte_sequence.data)
			super(@byte_sequence.stream_size)
		end

		def initialize(klass : ::Class)
			@data = klass.to_s
			@byte_sequence = ByteSequence.new(@data)
			super(@byte_sequence.stream_size)
		end

		def initialize(mod : ::Module)
			@data = mod.to_s
			@byte_sequence = ByteSequence.new(@data)
			super(@byte_sequence.stream_size)
		end

		def dump
			result = ::Bytes.new(1)
			result[0] = UInt8.new(0x63)
			result.concat(@byte_sequence.dump)
		end

	end

end

