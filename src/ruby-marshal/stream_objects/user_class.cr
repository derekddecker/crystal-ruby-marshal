require "./stream_object"

module Ruby::Marshal

	# “C” represents a subclass of a String, Regexp, Array 
	# or Hash. Following the type byte is a symbol 
	# containing the name of the subclass. Following the 
	# name is the wrapped object.
	class UserClass < StreamObject

		getter :data, :class_name
    @data : Hash::RawHashObjects
		@class_name : Symbol

		def initialize(stream : Bytes)
			@class_name = StreamObjectFactory.get(stream).as(Symbol)
      super(@class_name.stream_size)
			stream += @class_name.stream_size
			obj = StreamObjectFactory.get(stream)
			@size += obj.stream_size
			@data = obj.data
		end

		def dump
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

