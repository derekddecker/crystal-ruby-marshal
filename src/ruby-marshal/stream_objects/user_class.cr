require "./stream_object"

module Ruby::Marshal

	# “C” represents a subclass of a String, Regexp, Array 
	# or Hash. Following the type byte is a symbol 
	# containing the name of the subclass. Following the 
	# name is the wrapped object.
	class UserClass < StreamObject

		getter :data, :class_name
    @data : StreamObject
		@class_name : Symbol

		def initialize(stream : Bytes)
			@data = Null.new
			@class_name = StreamObjectFactory.get(stream).as(Symbol)
      super(@class_name.stream_size)
			stream += @class_name.stream_size
			read(stream)
		end

		def read(stream : Bytes)
			@data = StreamObjectFactory.get(stream)
			@size += @data.stream_size
		end

		def dump(bytestream : ::Bytes)
			#output = ::Bytes.new(1) 
			#output[0] = @type_byte
			#bytestream.concat(output)
		end

	end

end

