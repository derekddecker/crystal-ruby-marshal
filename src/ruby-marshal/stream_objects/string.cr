require "./stream_object"

module Ruby::Marshal

	STRING_ID = 0x0
	STRING_TYPE_IDENTIFIER = Int8.new(34) # """

	class String < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			string_length = IntegerStreamObject.get(stream)
      super(STRING_ID, string_length.data, STRING_TYPE_IDENTIFIER)
			stream += string_length.size
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			@data = ::String.new(stream[0, size])
		end

		def stream_size
			size
		end

	end

end
