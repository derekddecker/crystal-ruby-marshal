require "./stream_object"

module Ruby::Marshal

	class NullStreamObject < StreamObject

		def initialize
			super(0x00, 0x00)
			@data = 0x00
		end

		def read(stream : Bytes)
			# noop
			@data = 0x00
		end

	end

end
