require "./integer_stream_object"

module Ruby::Marshal

	ONE_BYTE_INT_ID = 0x00
	ONE_BYTE_INT_LENGTH = 0x01
	class OneByteInt < IntegerStreamObject

		def initialize
			super(ONE_BYTE_INT_ID, ONE_BYTE_INT_LENGTH)
			@data = Int8.new(0)
		end

		def read(stream : Bytes)
			data_bytes = stream[0, ONE_BYTE_INT_LENGTH]
			# negative if first bit is 1
			if ((data_bytes[0] & (1 << 7)) != 0)
				# get two's complement
				@data = Int8.new(data_bytes[0]) + 5
#				@data = -(Int8.new(~data_bytes[0] - (2 ^ 7))) - 1
			else # positive
				# If the value is positive the value is determined by 
				# subtracting 5 from the value.
				@data = Int8.new(data_bytes[0] - 5)
			end
			@data
		end

		def stream_size : Int32
			return 1 + ONE_BYTE_INT_LENGTH	
		end

	end

end
