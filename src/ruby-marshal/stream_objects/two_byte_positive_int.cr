require "./integer"

module Ruby::Marshal

	class TwoBytePositiveInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x02))
			read(stream)
		end

		def read(stream : Bytes)
			@data = Int32.new(::IO::ByteFormat::LittleEndian.decode(UInt16, stream[1, size]))
		end

		def dump(bytestream : ::Bytes)
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
