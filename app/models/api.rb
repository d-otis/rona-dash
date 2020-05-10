class API

	def start
		url = "https://corona.lmao.ninja/v2/countries"
		doc = HTTParty.get(url)
		doc.each do |element|
			Continent.find_or_create_by_name(element["continent"])
			Country.new(element)
		end
		Continent.find("").name = "Ships"

		State.create(combined_hashes(states_info_hashes, states_current_hashes))
		
		screenshots

		"API call complete."
	end

	def states_info_hashes
		info_url = "https://covidtracking.com/api/v1/states/info.json"

		doc_states_info = HTTParty.get(info_url)

		doc_states_info.collect do |state|
			{
				state: state["state"],
				name: state["name"],
				covid19SiteOld: state["covid19SiteOld"],
				covid19Site: state["covid19Site"],
				covid19SiteSecondary: state["covid19SiteSecondary"],
				twitter: state["twitter"],
				notes: state["notes"]
			}
		end
	end

	def states_current_hashes
		states_current_url = "https://covidtracking.com/api/v1/states/current.json"
		doc_states_current = HTTParty.get(states_current_url)

		doc_states_current.collect do |state|
			{
				state: state["state"],
				positive: state["positive"],
				negative: state["negative"],
				recovered: state["recovered"],
				death: state["death"],
				totalTestResults: state["totalTestResults"],
				dataQualityGrade: state["dataQualityGrade"],
				notes: state["notes"],
				hospitalizedCurrently: state["hospitalizedCurrently"],
				hospitalizedCumulative: state["hosiitalizedCumulative"],
				inIcuCurrently: state["inIcuCurrently"],
				inIcuCumulative: state["inIcuCumulative"],
				onVentilatorCurrently: state["onVentilatorCurrently"],
				onVentilatorCumulative: state["onVentilatorCumulative"],
				dateModified: state["dateModified"],
				dateChecked: state["dateChecked"]
			}
		end
	end

	def combined_hashes(info_hashes, current_hashes)
		# zipper these two hashes together
		info_hashes.collect do |info_hash|
			matched_current_hash = current_hashes.find {|current_hash| current_hash[:state] == info_hash[:state]}
			info_hash.merge(matched_current_hash)
		end
	end

	def screenshots
		screenshots_url = "https://covidtracking.com/api/v1/states/screenshots.json"
		doc_screenshots = HTTParty.get(screenshots_url)

		doc_screenshots.each do |hash|
			Screenshot.new(hash)
		end
	end

end