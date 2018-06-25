require "./stream_object"

module Ruby::Marshal

	# “/” represents a regular expression. Following the 
	# type byte is a byte sequence containing the regular 
	# expression @byte_sequence. Following the type byte is a byte 
	# containing the regular expression options (case-
	# insensitive, etc.) as a signed 8-bit value.
	#
	# Regular expressions can have an encoding attached 
	# through instance variables (see above). If no encoding 
	# is attached escapes for the following regexp specials 
	# not present in ruby 1.8 must be removed: g-m, o-q, u, 
	# y, E, F, H-L, N-V, X, Y.
	class Regex < StreamObject

		getter :data
    @data : ::Regex
		@byte_sequence : ByteSequence
		TYPE_BYTE = UInt8.new(0x2f)

		def initialize(stream : Bytes, @data : ::Regex = ::Regex.new(""))
			@byte_sequence = ByteSequence.new(stream)
			# The flags are a lie. Ruby does not marshal the option data :(
			#flags = ByteSequence.new(stream)
			@data = ::Regex.new(::String.new(@byte_sequence.data))
			super(@byte_sequence.stream_size)
		end

		def initialize(regex : ::Regex)
			@byte_sequence = ByteSequence.new(regex.source)
			@data = regex
			super(@byte_sequence.stream_size)
		end

		def dump
			result = ::Bytes.new(1)
			result[0] = TYPE_BYTE
			result.concat(@byte_sequence.dump)
		end

	end

end

