class Continent

	attr_accessor :name, :countries

	@@all = []

	def initialize(name)
		@name = name	
		@countries = []
	end

	def self.create(name)
		continent = self.new(name)
		continent.save
		continent
	end

	def save
		self.class.all << self
	end

	def self.find_or_create_by_name(name)
		if !self.find(name)
			self.create(name)
		else
			self.find(name)
		end
	end

	def self.find(name)
		self.all.detect {|continent| continent.name == name}
	end

	def self.all
		@@all
	end

	def slug
		self.name.downcase.gsub(/[!?@ +,&\/]/, "-").gsub(/[().']/, "").gsub("$", "s").squeeze("-")
	end

	def self.find_by_slug(slug)
		self.all.find {|instance| instance.slug == slug} 
	end

	def self.first
		self.all.first
	end

	def self.last
		self.all.last
	end

	def total
		self.countries.collect {|country| country.cases}.reduce(:+).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
	end
end