module Ruby::Marshal

	abstract class StreamObject

		getter :id, :size, :object_identifier

		def initialize(@id : Int32, @size : Int32, @object_identifier : Int8)
		end

		abstract def read(stream : Bytes)

		def stream_size : Int32
			# 1 for the 8 bit identifier "i"
			# 1 for the length byte
			return (1 + 1 + @size)
		end

	end

end
