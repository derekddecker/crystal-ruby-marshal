require "./integer"

module Ruby::Marshal

	class ThreeByteNegativeInt < Integer

		SUB_TYPE_BYTE = UInt8.new(0xfd)

		def initialize(stream : Bytes)
			super(Int32.new(0x03))
			stream += 1
			data_bytes = Slice(UInt8).new(size)
			data_bytes.copy_from(stream.to_unsafe, size)
			# endian flip
			data_bytes.reverse!
			# pad + complement
			padded_slice = Slice(UInt8).new(4)
			padded_slice[1] = ~data_bytes[0]
			padded_slice[2] = ~data_bytes[1]
			padded_slice[3] = ~data_bytes[2]
			@data = -(IO::ByteFormat::BigEndian.decode(Int32, padded_slice) + 1)
		end

		def initialize(int : ::Int32)
			super(Int32.new(0x02))
			@data = int
		end

		def dump
			output = ::Bytes.new(2)
			output[0] = Integer::TYPE_BYTE
			output[1] = SUB_TYPE_BYTE
			data_slice = ::Bytes.new(3)
			io = ::IO::Memory.new(0x03)
			@data.to_io(io, ::IO::ByteFormat::LittleEndian)
			io.rewind.read(data_slice)
			output.concat(data_slice)
		end

	end

end

