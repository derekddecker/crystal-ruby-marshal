require "./integer"

module Ruby::Marshal

	# “l” represents a Bignum which is composed of three parts:
	# 
	# sign
	# A single byte containing “+” for a positive value or “-” 
	# for a negative value.
	#
	# length
	# A long indicating the number of bytes of Bignum data follows, 
	# divided by two. Multiply the length by two to determine the 
	# number of bytes of data that follow.
	#
	# data
	# Bytes of Bignum data representing the number.
	class BigNum < StreamObject

		@data : ::Bytes
		@length : Integer
		@sign : UInt8
		getter :data, :sign, :length

		def initialize(stream : Bytes)
			super(0x00)
			@data = Bytes.new(0x00)
			@sign = stream.first
			stream += 1
			@size += 1

			@length = Integer.get(stream)
			stream += @length.size
			@size += @length.size	
			read(stream)
		end

		def read(stream : Bytes)
			@data = stream[0, @length.data * 2]	
			@size += @length.data * 2
		end

	end

end
