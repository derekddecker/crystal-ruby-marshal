require "./stream_object"
require "./array"

module Ruby::Marshal

	class ObjectPointer < StreamObject

    @data : Hash::RawHashObjects
		getter :data

		def initialize(stream : Bytes)
			pointer_index = Integer.get(stream)
      super(pointer_index.stream_size)
			@heap_index = Int32.new(pointer_index.data)
			@data = Heap.get_obj(@heap_index).data
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

