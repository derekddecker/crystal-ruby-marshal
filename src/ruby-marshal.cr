require "./ruby-marshal/*"

module Ruby::Marshal
  
	def self.load(source : String)
    self._load(source.to_slice)
	end

	def self.load(source : IO)
    self._load(source.gets_to_end)
	end

	def self._load(source : Bytes)
		validate_version!(source)
	end

	# First 2 bytes contain the version
	def self.validate_version!(source : Bytes)
		major_version = source[0, 1].first
		minor_version = source[1, 1].first

		unless major_version == 4 && minor_version == 8
			version = "#{major_version}.#{minor_version}"
			raise UnsupportedVersion.new("Unsupported version encountered in marshalled data. #{version} != 4.8.")
		end
  end

end
