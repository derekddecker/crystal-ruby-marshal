require "./stream_object"
require "./hash"

module Ruby::Marshal

	# For a Hash with a default value, the default value follows 
	# all the pairs.
	class HashWithDefault < Hash

		def initialize(stream : Bytes)
			@default_value = Null.new
			super(stream)
			data_with_default = ::Hash(StreamObject, StreamObject).new { @default_value }
			data_with_default.merge!(@data)
			@data = data_with_default
			@size += @default_value.stream_size
		end

		def read(stream : Bytes)
			stream = super(stream)
			# Get the default value
			@default_value = StreamObjectFactory.get(stream)
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

