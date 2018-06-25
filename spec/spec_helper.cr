require "spec"
require "../src/ruby-marshal"

SPEC_ROOT = File.dirname( __FILE__ )

class User

	property :id, :name, :valid, :data

  def initialize(marshalled_object : ::Ruby::Marshal::StreamObject)
		marshalled_object = marshalled_object.as(::Ruby::Marshal::Object)
		@id = marshalled_object.read_raw_attr("id").as(::Int32)
		@name = marshalled_object.read_raw_attr("name").as(::String)
		@valid = marshalled_object.read_raw_attr("valid").as(::Bool)
		@data = ::Hash(::String | ::Int32 | ::Hash(::String, ::Int32), ::Bool | ::String | ::Int32).new
		raw_data = marshalled_object.read_attr("data").as(::Hash) 
		@data["some"] = raw_data["some"].as(::Bool)
		@data[1] = raw_data[1].as(::String)
		@data[{"key" => 1}] = raw_data[{"key" => 1}].as(Int32)
	end

end

class ExtendedUser

	Ruby::Marshal.mapping({
		id: ::Int32,
	})
end

struct Customer
	Ruby::Marshal.mapping({
		name: ::String,
		address: ::String,
		valid: ::Bool,
		age: ::Int32,
	})
end

module TestModule

end

class DumpTestUser

	def initialize ; end

	Ruby::Marshal.mapping({
		id: ::Int32,
		name: ::String,
		valid: ::Bool,
		opts: ::Hash(String, String),
	})
end
