module Ruby::Marshal

	abstract class StreamObject

		getter :id, :size, :data
		@data : UInt8 | Int8 | UInt16 | Int16 | UInt32 | Int32 | ::Symbol | ::Nil

		def initialize(@id : Int32, @size : Int32)
		end

		abstract def read(stream : Bytes)

	end

end
