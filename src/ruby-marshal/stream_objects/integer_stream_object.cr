require "./stream_object"

module Ruby::Marshal

	INTEGER_TYPE_IDENTIFIER = Int8.new(105) # "i"

	abstract class IntegerStreamObject < StreamObject

		def initialize(@id : Int32, @size : Int32)
			super(@id, @size, INTEGER_TYPE_IDENTIFIER)
		end

	end

end