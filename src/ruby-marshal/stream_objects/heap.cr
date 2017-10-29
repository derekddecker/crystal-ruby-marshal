require "./stream_object"

module Ruby::Marshal

	class Heap

		@@sym_heap = ::Array(Symbol).new
		@@obj_heap = ::Array(String | Array | StreamObject).new

		def self.add(symbol : Symbol)
			@@sym_heap << symbol
		end

		def self.add(object : ::Ruby::Marshal::ObjectObject)
			@@obj_heap << object
		end

		def self.add(object : ::Ruby::Marshal::String)
			@@obj_heap << object
		end

		def self.add(object : ::Ruby::Marshal::InstanceObject)
			@@obj_heap << object
		end

		def self.add(object : ::Ruby::Marshal::Array)
			@@obj_heap << object
		end

		def self.get_sym(index : Int32)
			@@sym_heap[index]
		end

		def self.get_obj(index : Int32)
			@@obj_heap[index - 1]
		end

		def self.init
		  @@sym_heap.clear
		  @@obj_heap.clear
    end

	end

end
