class State

	attr_accessor 	:state, :name, :twitter, :notes, :covid19SiteOld, 
					:covid19Site, :covid19SiteSecondary, :positive, 
					:negative, :dataQualityGrade, :hospitalizedCurrently,
					:hosiitalizedCumulative, :inIcuCurrently, :inIcuCumulative,
					:onVentilatorCurrently, :onVentilatorCumulative, :recovered,
					:death, :totalTestResults, :dateModified, :dateChecked, :screenshots

	@@all = []

	def initialize(hash)
		hash.each {|k, v| self.send("#{k}=", v)}

		@screenshots = []
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

	def print_twitter
		if self.has_twitter?
			"<a href=\"https://www.twitter.com/#{self.twitter[1..-1]}\" target=\"_blank\"><i class=\"fab fa-twitter\"></i></a>"
		end
	end

	def has_twitter?
		self.twitter.nil? ? false : true
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

	def print_icu_current
		format_num(self.inIcuCurrently)
	end

	def print_hospitalized_current
		format_num(self.hospitalizedCurrently)
	end

	def print_vent_current
		format_num(self.onVentilatorCurrently)
	end

	def print_time_checked
		time = Time.parse(self.dateChecked)
		"Last checked: #{time.strftime("%D")} @ #{time.strftime("%I:%M %p")}"
	end

	def print_time_modified
		time = Time.parse(self.dateModified)
		"Last modified: #{time.strftime("%D")} @ #{time.strftime("%I:%M %p")}"
	end

	def print_grade
		grade = self.dataQualityGrade
		if ["A+", "A"].include?(grade)
			"<span class='badge badge-pill badge-success'>#{grade}</span>"
		elsif grade == "B"
			"<span class='badge badge-pill badge-primary'>#{grade}</span>"
		elsif grade == "C"
			"<span class='badge badge-pill badge-warning'>#{grade}</span>"
		else
			"<span class='badge badge-pill badge-danger'>#{grade}</span>"
		end
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

	def last_screenshot
		self.screenshots.last.url
	end
end