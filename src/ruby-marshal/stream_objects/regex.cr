require "./stream_object"

module Ruby::Marshal

	# “/” represents a regular expression. Following the 
	# type byte is a byte sequence containing the regular 
	# expression source. Following the type byte is a byte 
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

		def initialize(stream : Bytes, @data : ::Regex = ::Regex.new(""))
      super(0x00)
			read(stream)
		end

		def read(stream : Bytes)
			source = ByteSequence.new(stream)
			stream += source.stream_size
			# The flags are a lie. Ruby does not marshal the option data :(
			#flags = ByteSequence.new(stream)
			@data = ::Regex.new(::String.new(source.data))
			@size += source.stream_size # + flags.stream_size
		end

	end

end

