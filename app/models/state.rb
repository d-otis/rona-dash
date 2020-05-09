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

	def print_pos
		format_num(self.positive)
	end

	def print_neg
		format_num(self.negative)
	end

	def print_tests
		format_num(self.totalTestResults)
	end

	def print_recovered
		format_num(self.recovered)
	end

	def print_death
		format_num(self.death)
	end

	def format_num(num)
		if !num.nil?
			num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
		else
			"Not provided."
		end
	end

	def self.find(abbrev)
		self.all.find {|state| state.state == abbrev}
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