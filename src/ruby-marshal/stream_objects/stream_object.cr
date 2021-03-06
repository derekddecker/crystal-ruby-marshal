module Ruby::Marshal

	abstract class StreamObject

		getter :size

		def initialize(@size : Int32)
		end

		def stream_size
			# 1 for the 8 bit identifier
			return (1 + @size)
		end

	end

end
