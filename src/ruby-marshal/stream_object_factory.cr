require "./stream_objects"

module Ruby::Marshal

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			obj_type = stream[0]
			stream += 1
			case obj_type
				when INTEGER_TYPE_IDENTIFIER # "i"
					puts "found integer"
					return IntegerStreamObject.get(stream)
				when SYMBOL_TYPE_IDENTIFIER # ":"
					puts "found symbol"
					return Symbol.new(stream)
				when SYMBOL_POINTER_TYPE_IDENTIFIER # ":"
					puts "found symbol pointer"
					return SymbolPointer.new(stream)
				when ARRAY_TYPE_IDENTIFIER # "["
					puts "found array"
					return Array.new(stream)
				when STRING_TYPE_IDENTIFIER
					return String.new(stream)
				when OBJECT_POINTER_TYPE_IDENTIFIER # "@"
					puts "found symbol pointer"
					return SymbolPointer.new(stream)
				when TRUE_TYPE_IDENTIFIER
					return BoolStreamObject.new(true)
				when FALSE_TYPE_IDENTIFIER
					return BoolStreamObject.new(false)
				when NIL_TYPE_IDENTIFIER
					return NullStreamObject.new(stream)
				else
					puts "found null object (#{obj_type})"
					return NullStreamObject.new(stream)
			end
		end

	end

end
