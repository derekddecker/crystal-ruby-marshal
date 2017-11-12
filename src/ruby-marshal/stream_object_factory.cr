require "./stream_objects"

module Ruby::Marshal

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			id = stream.first
			stream += 1
			case id
				when Int8.new(105); Integer.get(stream)
				when Int8.new(70); False.new(stream)
				when Int8.new(48); Null.new(stream)
				when Int8.new(64); ObjectPointer.new(stream)
				when Int8.new(34); String.new(stream)
				when Int8.new(58); Symbol.new(stream)
				when Int8.new(59); SymbolPointer.new(stream)
				when Int8.new(84); True.new(stream)
				when Int8.new(91); Array.new(stream)
				when Int8.new(73); InstanceObject.new(stream)
				when Int8.new(111); Object.new(stream)
				when Int8.new(101); ExtendedObject.new(stream)
				when Int8.new(102); Float.new(stream)
				when Int8.new(123); Hash.new(stream)
				when Int8.new(125); HashWithDefault.new(stream)
				when Int8.new(108); BigNum.new(stream)
				when Int8.new(99); Class.new(stream)
				when Int8.new(109); Module.new(stream)
				when Int8.new(47); Regex.new(stream)
				when Int8.new(83); Struct.new(stream)
				when Int8.new(67); UserClass.new(stream)
				else raise InvalidMarshalData.new("Unknown type byte identifier: #{id}")
			end
		end

		def self.from(obj : ::Bool) : StreamObject
			obj ? True.new(obj) : False.new(obj) 
		end

		def self.from(obj : ::Nil) : StreamObject
			Null.new
		end

		def self.from(obj : ::Class) : StreamObject
			Ruby::Marshal::Class.new(obj)
		end

		def self.from(sym : ::Symbol) : StreamObject
			Ruby::Marshal::Symbol.new(sym)
		end

		def self.from(int : ::UInt8 |::Int8 | ::UInt16 | ::Int16 | ::UInt32 | ::Int32 | ::UInt64 | ::Int64) : StreamObject
			Ruby::Marshal::Integer.get(int)
		end

		def self.from(float : ::Float) : StreamObject
			Ruby::Marshal::Float.new(float)
		end

		def self.from(string : ::String) : StreamObject
			Ruby::Marshal::String.new(string)
		end

		def self.from(array : ::Array) : StreamObject
			Ruby::Marshal::Array.new(array)
		end

	end

end
