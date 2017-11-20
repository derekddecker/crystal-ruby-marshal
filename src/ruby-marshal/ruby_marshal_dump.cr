class Object
	def ruby_marshal_dump
		Ruby::Marshal::Object.from(self)
	end
end

struct Nil
	def ruby_marshal_dump
		Ruby::Marshal::Null.new
	end
end

struct Bool
	def ruby_marshal_dump
		self ? Ruby::Marshal::True.new(self) : Ruby::Marshal::False.new(self) 
	end
end

class Class
	def ruby_marshal_dump
		Ruby::Marshal::Class.new(self)
	end
end

struct Symbol
	def ruby_marshal_dump
		Ruby::Marshal::Symbol.new(self)
	end
end

struct Int
	def ruby_marshal_dump
		Ruby::Marshal::Integer.get(self)
	end
end

struct Float
	def ruby_marshal_dump
		Ruby::Marshal::Float.new(self)
	end
end

class String
	def ruby_marshal_dump
		Ruby::Marshal::String.new(self)
	end
end

class Array
	def ruby_marshal_dump
		Ruby::Marshal::Array.new(self)
	end
end

class Regex
	def ruby_marshal_dump
		Ruby::Marshal::Regex.new(self)
	end
end

class Hash
	def ruby_marshal_dump
			self.default_value ? 
				Ruby::Marshal::HashWithDefault.new(self) : 
				Ruby::Marshal::Hash.new(self)
	end
end

struct Struct
	def ruby_marshal_dump
		Ruby::Marshal::Struct.new(self)
	end
end
