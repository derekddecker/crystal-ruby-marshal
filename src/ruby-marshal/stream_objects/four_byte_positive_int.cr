require "./integer_stream_object"

module Ruby::Marshal

	class FourBytePositiveInt < IntegerStreamObject

		def initialize(stream : Bytes)
			super(Int32.new(0x04))
			read(stream)
		end

		def read(stream : Bytes)
			@data = ::IO::ByteFormat::LittleEndian.decode(Int32, stream[1, size])
		end

	end

end
