require "./integer_stream_object"

module Ruby::Marshal

	class OneBytePositiveInt < IntegerStreamObject

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			read(stream)
		end

		def read(stream : Bytes)
			@data = Int32.new(stream[1, size].join)
		end

	end

end
