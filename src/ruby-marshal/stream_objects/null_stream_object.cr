require "./stream_object"

module Ruby::Marshal

	class NullStreamObject < StreamObject

		@data : ::Nil
		getter :data

		def initialize
			super(0x00, 0x00, Int8.new(0))
			@data = nil
		end

		def read(stream : Bytes)
			# noop
		end

	end

end
