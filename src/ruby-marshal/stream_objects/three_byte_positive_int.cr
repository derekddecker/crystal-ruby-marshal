require "./integer"

module Ruby::Marshal

	class ThreeBytePositiveInt < Integer

		SUB_TYPE_BYTE = UInt8.new(0x03)

		def initialize(stream : Bytes)
			@data = Int32.new(0x00)
			super(Int32.new(0x03))
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

		def initialize(int : ::Int32)
			super(Int32.new(0x03))
			@data = int
		end

		def dump
			output = ::Bytes.new(2)
			output[0] = Integer::TYPE_BYTE # 3
			output[1] = SUB_TYPE_BYTE # 3
			io = ::IO::Memory.new(0x03)
			@data.to_io(io, ::IO::ByteFormat::LittleEndian)
			data_slice = ::Bytes.new(3)
			io.rewind.read(data_slice)
			output.concat(data_slice)
		end

	end

end
