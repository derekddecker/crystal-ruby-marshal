require "./stream_object"

module Ruby::Marshal

	class False < StreamObject

		@data : Bool
		getter :data

		def initialize(stream : Bytes)
			super(Int32.new(0x00))
			@data = false
		end

		def read(stream : Bytes)
			# noop
		end
	end

end

