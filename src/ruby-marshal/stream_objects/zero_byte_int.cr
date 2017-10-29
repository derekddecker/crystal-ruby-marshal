require "./integer"

module Ruby::Marshal

	class ZeroByteInt < Integer

		def initialize(stream : Bytes)
			super(Int32.new(0x01))
			read(stream)
		end

		def read(stream : Bytes)
			# noop
		end

	end

end
