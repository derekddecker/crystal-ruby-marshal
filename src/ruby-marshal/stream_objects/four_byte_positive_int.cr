require "./integer"

module Ruby::Marshal

	class FourBytePositiveInt < Integer

		SUB_TYPE_BYTE = UInt8.new(0x04)

		def initialize(stream : Bytes)
			super(Int32.new(0x04))
			@data = ::IO::ByteFormat::LittleEndian.decode(Int32, stream[1, size])
		end

		def initialize(int : ::Int32)
			super(Int32.new(0x04))
			@data = int
		end

		def dump
			output = ::Bytes.new(2)
			output[0] = Integer::TYPE_BYTE # 3
			output[1] = SUB_TYPE_BYTE # 3
			io = ::IO::Memory.new(0x04)
			@data.to_io(io, ::IO::ByteFormat::LittleEndian)
			data_slice = ::Bytes.new(4)
			io.rewind.read(data_slice)
			output.concat(data_slice)
		end

	end

end
