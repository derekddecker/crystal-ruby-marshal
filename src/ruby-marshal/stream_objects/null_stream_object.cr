require "./stream_object"

module Ruby::Marshal

	class NullStreamObject < StreamObject

		getter :data
    @data : ::Nil

		def initialize(stream : Bytes)
      super(Int32.new(0x00))
			@data = nil
		end

		def initialize
      super(Int32.new(0x00))
			@data = nil
		end

		def read(stream : Bytes)
			# noop
		end

	end

end

