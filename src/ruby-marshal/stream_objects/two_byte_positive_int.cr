require "./integer"

module Ruby::Marshal

	class TwoBytePositiveInt < Integer

		SUB_TYPE_BYTE = UInt8.new(0x02)

		def initialize(stream : Bytes)
			super(Int32.new(0x02))
			@data = Int32.new(::IO::ByteFormat::LittleEndian.decode(UInt16, stream[1, size]))
		end

		def initialize(int : ::Int32)
			super(Int32.new(0x02))
			@data = int
		end

		def dump
			output = ::Bytes.new(2)
			output[0] = UInt8.new(Integer::TYPE_BYTE)
			output[1] = UInt8.new(SUB_TYPE_BYTE)
			io = ::IO::Memory.new(0x02)
			@data.to_io(io, ::IO::ByteFormat::LittleEndian)
			data_slice = ::Bytes.new(2)
			io.rewind.read(data_slice)
			output.concat(data_slice)
		end

	end

end
