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

		def initialize(stream : Bytes)
			source = ByteSequence.new(stream)
			@data = ::String.new(source.data)
			super(source.stream_size)
			Heap.add(self)
		end

	end

end

