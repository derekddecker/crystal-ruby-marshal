require "./integer"

module Ruby::Marshal

	class ByteSequence
	
		getter :data, :length
		@length : Integer
	
		def initialize(stream : ::Bytes, @data : ::Bytes = ::Bytes.new(0x00))
			@length = Integer.get(stream)
			@data = stream[@length.size, @length.data]	
		end

		def initialize(str : ::String)
			@length = Integer.get(str.size)
			bytes = str.bytes
			i = 0
			result = ::Bytes.new(bytes.size)
			while(i < bytes.size)
				result[i] = bytes[i]
				i += 1
			end
			@data = result
		end

		def stream_size
			@length.data
		end
		
		def dump : ::Bytes
			result = @length.dump 
			if result
				result[1, result.size - 1].concat(@data)  # strip the "i" type byte
			else
				::Bytes.new(0).concat(@data)
			end
		end

	end

end
