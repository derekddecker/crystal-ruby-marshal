require "./integer"

module Ruby::Marshal

	class ByteSequence
	
		getter :data
		@length : Integer
	
		def initialize(stream : ::Bytes, @data : ::Bytes = ::Bytes.new(0x00))
			@length = Integer.get(stream)
			@data = stream[@length.size, @length.data]	
		end

		def stream_size
			@length.size + @length.data
		end

	end

end
