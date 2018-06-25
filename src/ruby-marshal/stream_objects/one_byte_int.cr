require "./integer"

module Ruby::Marshal

	class OneByteInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			data_bytes = stream[0, size]
			# negative if first bit is 1
			if ((data_bytes[0] & (1 << 7)) != 0)
				# get two's complement
				@data = Int32.new(Int8.new(data_bytes[0]) + 5)
			else # positive
				# If the value is positive the value is determined by
				# subtracting 5 from the value.
				@data = Int32.new(Int8.new(data_bytes[0] - 5))
			end
		end

		def initialize(int : ::Int32)
			super(Int32.new(0x01))
			@data = int
		end

		def dump
			output = ::Bytes.new(2)
			output[0] = UInt8.new(Integer::TYPE_BYTE)
			if @data < 0
				output[1] = UInt8.new((@data - 5)) | (1 << 7)
			else
				output[1] = UInt8.new(@data + 5)
			end
			output
		end

		def stream_size
			2
		end

	end

end

