struct Slice(T)

		# Cocatenate the passed slice onto the end of the slice
		def concat(slice : ::Slice)
			result = ::Slice(T).new(self.size + slice.size)
			self.each_with_index { |b, i| result[i] = b }
			slice.each_with_index { |b, i| result[i + self.size] = b }
			return result
		end

end

