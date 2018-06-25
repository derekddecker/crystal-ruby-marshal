require "./stream_object"
require "./object"

module Ruby::Marshal

	# For a Hash with a default value, the default value follows 
	# all the pairs.
	class ExtendedObject < Object

		def initialize(stream : Bytes)
			@extended_by = Null.new
			super(stream)
			@size += @extended_by.stream_size
		end

		def read(stream : Bytes)
			stream = super(stream)
			# Get the module that extends the object
			@extended_by = StreamObjectFactory.get(stream)
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

