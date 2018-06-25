require "./stream_object"
require "./hash"

module Ruby::Marshal

	# For a Hash with a default value, the default value follows 
	# all the pairs.
	class HashWithDefault < Hash

		TYPE_BYTE = UInt8.new(0x7d)

		def initialize(stream : Bytes)
			@num_keys = Integer.get(0)
			@default_value = nil
			super(stream)
			data_with_default = ::Hash(RawHashObjects, RawHashObjects).new { @default_value.ruby_marshal_dump.data }
			data_with_default.merge!(@data)
			@data = data_with_default
			@size += @default_value.ruby_marshal_dump.stream_size
		end

		def read(stream : Bytes)
			stream = super(stream)
			# Get the default value
			@default_value = StreamObjectFactory.get(stream).data
		end

		def initialize(hash : ::Hash(RawHashObjects, RawHashObjects))
			@size = 0
			tmp_default = hash.default_value
			@default_value = tmp_default.ruby_marshal_dump.data
			@data = ::Hash(RawHashObjects, RawHashObjects).new
			@num_keys = Integer.get(hash.keys.size)
			super(hash)
			hash.each do |key, value|
				instance_var_name = key.ruby_marshal_dump
				@size += instance_var_name.stream_size
				instance_var_value = value.ruby_marshal_dump
				@size += instance_var_value.stream_size
				@data[instance_var_name.data] = instance_var_value.data
			end
		end

		def dump
			output = super()
			output[0] = TYPE_BYTE
			output.concat(@default_value.ruby_marshal_dump.dump || ::Bytes.new(0))
		end

	end

end

