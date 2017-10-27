require "./stream_object"

module Ruby::Marshal

	TRUE_TYPE_IDENTIFIER = Int8.new(84) # "T"
	FALSE_TYPE_IDENTIFIER = Int8.new(70) # "F"

	class BoolStreamObject < StreamObject

		getter :data
    @data : ::Bool

		def initialize(val : Bool)
      super(0x00, Int32.new(0x00), Int8.new(0))
			@data = val
		end

		def read(stream : Bytes)
			# noop
		end

		def stream_size
			1
		end

	end

end
