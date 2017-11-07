require "./integer"

module Ruby::Marshal

	class OneByteInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			read(stream)
		end

		def read(stream : Bytes)
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
			@data
		end

		def stream_size
			# 1 for 8-bit identifier "i"
			# 1 for the 1 byte value
			return 2
		end

		def dump(bytestream : ::Bytes)
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

