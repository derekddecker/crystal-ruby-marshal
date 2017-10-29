require "./stream_objects"

module Ruby::Marshal

	class StreamObjectFactory

		def self.get(stream : Bytes) : StreamObject
			id = stream.first
			stream += 1
			case id
				when Int8.new(105); IntegerStreamObject.get(stream)
				when Int8.new(70); FalseStreamObject.new(stream)
				when Int8.new(0); NullStreamObject.new(stream)
				when Int8.new(64); ObjectPointer.new(stream)
				when Int8.new(34); String.new(stream)
				when Int8.new(58); Symbol.new(stream)
				when Int8.new(59); SymbolPointer.new(stream)
				when Int8.new(84); TrueStreamObject.new(stream)
				when Int8.new(91); Array.new(stream)
				when Int8.new(73); InstanceObject.new(stream)
				when Int8.new(111); ObjectObject.new(stream)
				when Int8.new(123), Int8.new(125); Hash.new(stream)
				else return NullStreamObject.new(stream)
			end
		end

	end

end
