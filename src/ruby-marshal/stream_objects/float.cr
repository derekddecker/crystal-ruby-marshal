require "./integer"

module Ruby::Marshal

	class Float < StreamObject

		@data : ::Float64
		@length : Integer
		getter :data

		def initialize(stream : Bytes)
			@data = ::Float64.new(0x00)
			@length = Integer.get(stream)
			stream += @length.size
			super(@length.size)
			read(stream)
			@size += @length.stream_size
		end

		def read(stream : Bytes)
			float_io = ::IO::Memory.new(stream[0, @length.data])
			@data = ::Float64.new(float_io.to_s)
		end

	end

end
