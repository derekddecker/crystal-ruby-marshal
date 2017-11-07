require "./integer"

module Ruby::Marshal

	# “f” represents a Float object. Following the type byte 
	# is a byte sequence containing the float value. The 
	# following values are special:
	# 
	# “inf” - Positive infinity
	# “-inf” - Negative infinity
	# “nan” - Not a Number
	# 
	# Otherwise the byte sequence contains a C double (loadable 
	# by strtod(3)). Older minor versions of Marshal also stored 
	# extra mantissa bits to ensure portability across platforms
	# but 4.8 does not include these.
	class Float < StreamObject

		@data : ::Float64
		getter :data

		def initialize(stream : Bytes)
			source = ByteSequence.new(stream)
			float_io = ::IO::Memory.new(source.data)
			@data = ::Float64.new(float_io.to_s)
			super(source.stream_size)
		end

		def dump(bytestream : ::Bytes)
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
