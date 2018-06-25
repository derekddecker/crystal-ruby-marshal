class Hash(K, V)

	def default_value
		return (fetch("nonexistent") rescue nil)
		fetch(nil) rescue nil
	end

end