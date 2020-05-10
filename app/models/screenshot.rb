class Screenshot

	attr_accessor :state, :url, :dateChecked, :secondary, :date, :size

	@@all = []

	def initialize(hash)
		hash.each do |k, v| 
			if k != "state"
				self.send("#{k}=", v)
			else
				@state = State.find(v)
				@state.screenshots << self
			end
		end
		save
	end

	def save
		self.class.all << self
	end

	def self.all
		@@all
	end

end	