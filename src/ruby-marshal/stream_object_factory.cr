require "./stream_objects"

module Ruby::Marshal

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			id = stream.first
			stream += 1
			case id
				when Int8.new(105); Integer.get(stream)
				when Int8.new(70); False.new(stream)
				when Int8.new(0); Null.new(stream)
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
				else return Null.new(stream)
			end
		end

	end

end
