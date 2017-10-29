require "./stream_object"

module Ruby::Marshal

	class String < StreamObject

		getter :data

		def initialize(stream : Bytes)
			@data = ""
			string_length = IntegerStreamObject.get(stream)
      super(string_length.data)
			stream += string_length.size
			read(stream)
			Heap.add(self)
		end

		def read(stream : Bytes)
			@data = ::String.new(stream[0, size])
		end

	end

end

