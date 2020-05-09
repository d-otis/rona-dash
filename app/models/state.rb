class State

	attr_accessor 	:state, :name, :twitter, :notes, :covid19SiteOld, 
					:covid19Site, :covid19SiteSecondary, :positive, 
					:negative, :dataQualityGrade, :hospitalizedCurrently,
					:hosiitalizedCumulative, :inIcuCurrently, :inIcuCumulative,
					:onVentilatorCurrently, :onVentilatorCumulative, :recovered,
					:death, :totalTestResults, :dateModified, :dateChecked

	@@all = []

	def initialize(hash)
		hash.each {|k, v| self.send("#{k}=", v)}

		@counties = []
	end

	def save
		self.class.all << self
	end

	def self.all
		@@all
	end

	def self.create(hashes)
		hashes.each do |hash|
			state = self.new(hash)
			state.save
		end
	end

	def self.find(state)
		self.all.find {|state| state.state == state}
	end

	def update_state(hash)
		binding.pry
	end

	def self.first
		self.all.first
	end

	def self.last
		self.all.last
	end
end