class State

	attr_accessor :state, :name, :twitter, :notes, :covid19SiteOld, :covid19Site, :covid19SiteSecondary

	@@all = []

	def initialize
		@counties = []
	end

	def self.all
		@@all
	end

	def self.first
		self.all.first
	end

	def self.last
		self.all.last
	end
end