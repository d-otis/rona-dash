class State

	attr_accessor 	:state, :name, :twitter, :notes, :covid19SiteOld, 
					:covid19Site, :covid19SiteSecondary, :screenshots, :dateModified, :dateChecked, 
					:positive, :negative, :dataQualityGrade, :hospitalizedCurrently,
					:hospitalizedCumulative, :inIcuCurrently, :inIcuCumulative,
					:onVentilatorCurrently, :onVentilatorCumulative, :recovered,
					:death, :totalTestResults

	@@all = []
	@@int_attrs = ["positive",
					 "negative",
					 "recovered",
					 "death",
					 "totalTestResults",
					 "dataQualityGrade",
					 "hospitalizedCurrently",
					 "hospitalizedCumulative",
					 "inIcuCurrently",
					 "inIcuCumulative",
					 "onVentilatorCurrently",
					 "onVentilatorCumulative"]

	def integer_attrs
		self.instance_variables[7...-3].collect{|attr| attr.to_s[1..-1]}
		# returns array of all integer attrs
	end

	@@int_attrs.each do |attr| 
		define_method("print_#{attr}") do 
			format_num(instance_variable_get("@#{attr}"))
		end
	end

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

	def print_twitter
		if self.has_twitter?
			"<a href=\"https://www.twitter.com/#{self.twitter[1..-1]}\" target=\"_blank\"><i class=\"fab fa-twitter\"></i></a>"
		end
	end

	def has_twitter?
		self.twitter.nil? ? false : true
	end

	def print_time_checked
		time = Time.parse(self.dateChecked)
		"Last checked: #{time.strftime("%D")} @ #{time.strftime("%I:%M %p")} UTC"
	end

	def print_time_modified
		time = Time.parse(self.dateModified)
		"Last modified: #{time.strftime("%D")} @ #{time.strftime("%I:%M %p")} UTC"
	end

	def print_grade
		grade = self.dataQualityGrade
		case grade
		when "A+", "A"
			css = "success"
		when "B"
			css = "primary"
		when "C"
			css = "warning"
		else
			css = "danger"
		end
		"<span class='badge badge-pill badge-#{css}'>#{grade}</span>"
	end

	def format_num(num)
		if !num.nil?
			num.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
		else
			"<small class='text-muted'><em>Not provided.</em></small>"
		end
	end

	def self.find(abbrev)
		self.all.find {|state| state.state == abbrev}
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