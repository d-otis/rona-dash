class API

	def start
		url = "https://corona.lmao.ninja/v2/countries"
		doc = HTTParty.get(url)
		doc.each do |element|
			Continent.find_or_create_by_name(element["continent"])
			Country.new(element)
		end
		Continent.find("").name = "Ships"
		"API call complete."
	end
end