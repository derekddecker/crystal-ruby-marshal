require "./stream_object"
require "./integer"

module Ruby::Marshal

	# ‘“’ represents a String. Following the type byte is a 
	# byte sequence containing the string content. When dumped 
	# from ruby 1.9 an encoding instance variable (:E see 
	# above) should be included unless the encoding is binary.
	class String < StreamObject

		getter :data
		@data : ::String
		@byte_sequence : ByteSequence
		TYPE_BYTE = UInt8.new(0x22)

		def initialize(stream : Bytes)
			@byte_sequence = ByteSequence.new(stream)
			@data = ::String.new(@byte_sequence.data)
			super(@byte_sequence.stream_size) 
			Heap.add(self)
		end

		def initialize(string : ::String)
			@byte_sequence = ByteSequence.new(string)
			@data = string
			super(@byte_sequence.stream_size)
		end

		def dump
			result = ::Bytes.new(1)
			result[0] = TYPE_BYTE
			result.concat(@byte_sequence.dump)
		end

	end

end

