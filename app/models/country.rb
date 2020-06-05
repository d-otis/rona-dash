class Country

	attr_accessor 	:country, :cases, :todayCases, :deaths, :todayDeaths, 
					:recovered, :critical, :countryInfo, :active, :casesPerOneMillion, 
					:deathsPerOneMillion, :updated, :tests, :testsPerOneMillion, :continent,
					:population, :activePerOneMillion, :recoveredPerOneMillion, :criticalPerOneMillion,
					:todayRecovered, :oneCasePerPeople, :oneDeathPerPeople, :oneTestPerPeople


	@@all = []

	def initialize(attrs)
		attrs.each do |k, v| 
			if k != "continent"
				self.send("#{k}=", v)
			else
				self.continent = Continent.find_or_create_by_name(v)
				Continent.find_or_create_by_name(v).countries << self
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

	def self.global_hash
		rec_hash = {
			:total_cases => 0,
			:recovered => 0,
			:deaths => 0
		}
		self.all.each do |country|
			rec_hash[:total_cases] += country.cases
			rec_hash[:recovered] += country.recovered
			rec_hash[:deaths] += country.deaths
		end
		rec_hash
	end

	def self.find_by_country(name)
		# Corona::Country.find_by_country("Spain")
		# needs to return a Country instance if exists
		name = name.downcase.strip
		self.all.find {|el| el.country.downcase == name}
	end

	def self.format_num(number)
		number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
	end

	def slug
		self.country.downcase.gsub(/[!?@ +,&]/, "-").gsub(/[().']/, "").gsub("$", "s").squeeze("-")
	end

	def self.find_by_slug(slug)
		self.all.find {|instance| instance.slug == slug} 
	end

end