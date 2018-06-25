require "./stream_object"
require "./integer"

module Ruby::Marshal

	class Symbol < StreamObject

		getter :data
		@type_byte = UInt8.new(0x3a)
		@byte_sequence : ByteSequence

		def initialize(stream : Bytes)
			@byte_sequence = ByteSequence.new(stream)
			@data = ::String.new(@byte_sequence.data)
			super(@byte_sequence.stream_size)
			Heap.add(self)
		end

		def initialize(sym : ::Symbol | ::String)
			@data = sym.to_s
			@byte_sequence = ByteSequence.new(@data)
			super(@byte_sequence.stream_size)
		end

		def dump
			output = ::Bytes.new(1) 
			output[0] = @type_byte
			output.concat(@byte_sequence.dump)
		end

	end

end

