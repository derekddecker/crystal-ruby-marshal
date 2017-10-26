require "./stream_objects"

module Ruby::Marshal

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			obj_type = stream[0]
			stream += 1
			case obj_type
				when INTEGER_TYPE_IDENTIFIER # "i"
					return IntegerStreamObject.get(stream)
				when SYMBOL_TYPE_IDENTIFIER # ":"
					return Symbol.new(stream)
				else
					return NullStreamObject.new
			end
		end

	end

end
