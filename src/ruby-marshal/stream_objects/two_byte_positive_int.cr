require "./integer_stream_object"

module Ruby::Marshal

	class TwoBytePositiveInt < IntegerStreamObject

		def initialize(stream : Bytes)
			super(Int32.new(0x02))
			read(stream)
		end

		def read(stream : Bytes)
			@data = Int32.new(::IO::ByteFormat::LittleEndian.decode(UInt16, stream[1, size]))
		end

	end

end
