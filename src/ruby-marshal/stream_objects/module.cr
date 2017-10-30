require "./stream_object"

module Ruby::Marshal

	class Module < StreamObject

		getter :data
    @data : ::Bytes
		@length : Integer

		def initialize(stream : Bytes)
			@data = ::Bytes.new(0x00)
			@length = Integer.get(stream)
      super(@length.size)
			stream += @length.size
			read(stream)
		end

		def read(stream : Bytes)
			# noop
			@data = stream[0, @length.data]
			@size += @length.data
		end

	end

end

