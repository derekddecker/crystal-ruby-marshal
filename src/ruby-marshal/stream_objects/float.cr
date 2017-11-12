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
		@byte_sequence : ByteSequence
		getter :data
		TYPE_BYTE = UInt8.new(0x66)

		def initialize(stream : Bytes)
			@byte_sequence = ByteSequence.new(stream)
			float_io = ::IO::Memory.new(@byte_sequence.data)
			@data = ::Float64.new(float_io.to_s)
			super(@byte_sequence.stream_size + @byte_sequence.length.size)
		end

		def initialize(float : ::Float64)
			@byte_sequence = ByteSequence.new(float.to_s)
			@data = float
			super(@byte_sequence.stream_size)
		end

		def dump
			result = ::Bytes.new(1)
			result[0] = UInt8.new(TYPE_BYTE)
			result.concat(@byte_sequence.dump)
		end

	end

end
