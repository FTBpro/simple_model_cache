require "simple_model_cache/version"

module SimpleModelCache

	def self.included(base)
		base.send :after_save, :reset_cache!
		base.extend(ClassMethods)
	end

	def reset_cache! 
		self.class.send :reset_storage!
	end

	module ClassMethods	

		def cache_fields(*fields)
			@cached_fields = [:id]
			@cached_fields += fields
			define_finder_methods
		end

		def find(*id_params)
			ids = id_params.compact
			from_cache = ids.count == 1 ? find_one(ids.first) : find_many(ids) 
			if from_cache.blank?
				super
			else
				from_cache
			end
		end

		private

		def storage
			@@storage ||= load_all
		end

		def reset_storage!
			@@storage = nil
		end

		def find_one(id)
			storage[cache_key(:id, id)]
		end

		def find_many(ids)
			cache_keys = ids.map {|id| cache_key(:id, id)}
			storage.values_at(*cache_keys)
		end

		def define_finder_methods
			@cached_fields.each do |field|
				finder_method = "find_by_#{field}"
				define_singleton_method(finder_method) do |arg|
					key = cache_key(field, arg)
					storage[key] || super(arg)
				end 
			end
		end 

		def load_all
			hash = {}
			all.each do |item|
				cache_by_each_field(hash, item)
			end
			hash
		end

		def cache_by_each_field(hash, item)
			@cached_fields.each do |field|
				key = cache_key(field, item.send(field).to_s)
				hash[key] = item
			end
		end

		def cache_key(field, value)
			"#{field}:#{value}"
		end

	end
end