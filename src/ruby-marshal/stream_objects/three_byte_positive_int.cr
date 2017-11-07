require "./integer"

module Ruby::Marshal

	class ThreeBytePositiveInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x03))
			read(stream)
		end

		def read(stream : Bytes)
			stream += 1
			data_bytes = Slice(UInt8).new(size)
			data_bytes.copy_from(stream.to_unsafe, size)
			data_bytes.reverse!
			padded_slice = Slice(UInt8).new(4)
			padded_slice[1] = data_bytes[0]
			padded_slice[2] = data_bytes[1]
			padded_slice[3] = data_bytes[2]
			@data = ::IO::ByteFormat::BigEndian.decode(Int32, padded_slice)
		end

		def dump(bytestream : ::Bytes)
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end
