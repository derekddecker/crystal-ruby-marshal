require "./integer"

module Ruby::Marshal

	class FourBytePositiveInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x04))
			read(stream)
		end

		def read(stream : Bytes)
			@data = ::IO::ByteFormat::LittleEndian.decode(Int32, stream[1, size])
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
