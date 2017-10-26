require "./stream_object"

module Ruby::Marshal

	class NullStreamObject < StreamObject

		getter :data
    @data : ::Nil

		def initialize
      super(0x00, Int32.new(0x00), Int8.new(0))
			@data = nil
		end

		def read(stream : Bytes)
			# noop
		end

	end

end
