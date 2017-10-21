require "./ruby-marshal/*"

module Ruby::Marshal

  MAJOR_VERSION = 4
	MINOR_VERSION = 8

	def self.load(source : String)
    self._load(source.to_slice)
	end

	def self.load(source : IO)
    self._load(source.gets_to_end)
	end

	# The first two bytes of the stream contain the major and minor version, each as 
	# a single byte encoding a digit. The version implemented in Ruby is 4.8 (stored 
	# as “x04x08”) and is supported by ruby 1.8.0 and newer.
	#
	# Different major versions of the Marshal format are not compatible and cannot be 
	# understood by other major versions. Lesser minor versions of the format can be 
	# understood by newer minor versions. Format 4.7 can be loaded by a 4.8 
	# implementation but format 4.8 cannot be loaded by a 4.7 implementation.
	#
	# Following the version bytes is a stream describing the serialized object. The 
	# stream contains nested objects (the same as a Ruby object) but objects in the 
	# stream do not necessarily have a direct mapping to the Ruby object model.
	# 
	# Each object in the stream is described by a byte indicating its type followed 
	# by one or more bytes describing the object. When “object” is mentioned below 
	# it means any of the types below that defines a Ruby object.
	# https://ruby-doc.org/core-2.2.2/doc/marshal_rdoc.html
	def self._load(source : Bytes)
		validate_version!(source)
		stream = source + 2
		process_stream(stream)
	end

	# First 2 bytes contain the version
	def self.validate_version!(source : Bytes)
		major_version = source[0, 1].first
		minor_version = source[1, 1].first

		unless major_version == MAJOR_VERSION && minor_version <= MINOR_VERSION
			version = "#{major_version}.#{minor_version}"
			raise UnsupportedVersion.new("Unsupported version encountered in marshalled data. #{version} != 4.8.")
		end
  end

	def self.process_stream(stream : Bytes)
		while (!stream.empty?)
			object_meta = next_type(stream)
			obj_stream_length = 1 + object_meta.object_size
			object = stream[0, obj_stream_length]
			process_object(object)
			stream = stream + obj_stream_length
		end
	end

	def self.next_type(stream : Bytes)
		StreamObjectMetaFactory.get(stream[0])
	end

	def self.process_object(object : Bytes)
		# TODO
	end

end
