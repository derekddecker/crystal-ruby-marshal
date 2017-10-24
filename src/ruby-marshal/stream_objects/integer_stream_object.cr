require "./stream_object"

module Ruby::Marshal

	INTEGER_TYPE_IDENTIFIER = Int8.new(105) # "i"

	abstract class IntegerStreamObject < StreamObject

		@data : UInt8 | Int8 | UInt16 | Int16 | UInt32 | Int32
		getter :data

		def initialize(@id : Int32, @size : Int32)
			super(@id, @size, INTEGER_TYPE_IDENTIFIER)
			@data = Int32.new(0)
		end

	end

end