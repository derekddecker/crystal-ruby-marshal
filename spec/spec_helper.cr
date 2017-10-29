require "spec"
require "../src/ruby-marshal"

SPEC_ROOT = File.dirname( __FILE__ )

class User

	property :id, :name, :valid, :data

	def initialize(marshalled_object : ::Ruby::Marshal::Object)
		@id = marshalled_object.read_raw_attr("id").as(::Int32)
		@name = marshalled_object.read_raw_attr("name").as(::String)
		@valid = marshalled_object.read_raw_attr("valid").as(::Bool)	
		@data = ::Hash(::String | ::Int32 | ::Hash(::String, ::Int32), ::Bool | ::String | ::Int32).new
		raw_data = marshalled_object.read_attr("data").as(Ruby::Marshal::Hash)
		@data["some"] = raw_data["some"].data.as(::Bool)
		@data[1] = raw_data[1].data.as(::String)
		raw_data.each do |(k,v )|
			if(k.class == Ruby::Marshal::Hash)
				@data[{"key" => 1}] = v.data.as(::Int32)
			end
		end
	end

end
