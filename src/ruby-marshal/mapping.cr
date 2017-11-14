require "./exception"

module Ruby::Marshal

	macro mapping(properties)

		def num_instance_vars
			Ruby::Marshal::Integer.get({{ properties.size }})
		end

		def instance_vars
			Ruby::Marshal::StreamObjectFactory.from({
		{% for prop, klass in properties %}
			"{{ prop.id }}" => @{{ prop.id }},
		{% end %}
			})
		end

		{% for prop, klass in properties %}
			property :{{ prop.id }}
		
			def read_ruby_marshalled_{{ prop.id }}(obj : ::Ruby::Marshal::Object | ::Ruby::Marshal::Struct) : {{klass}} 
				obj.read_raw_attr("{{ prop.id }}").as({{ klass }})
			end
		{% end %}

		def initialize(obj : ::Ruby::Marshal::StreamObject)
			{% for prop, klass in properties %}
				if self.is_a?(::Struct)
						@{{ prop.id }} = read_ruby_marshalled_{{ prop.id }}(obj.as(::Ruby::Marshal::Struct)).as({{ klass }})
				elsif self.is_a?(::Object)
						@{{ prop.id }} = read_ruby_marshalled_{{ prop.id }}(obj.as(::Ruby::Marshal::Object)).as({{ klass }})
					else; raise Ruby::Marshal::UnsupportedMarshalClass.new
				end
			{% end %}
		end

	end

end
