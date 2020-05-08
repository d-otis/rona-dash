class ContinentsController < ApplicationController

	get "/continents/:slug" do
		@continent = Continent.find_by_slug(params[:slug])
		@title = @continent.name
		@countries = @continent.countries.sort_by(&:cases).reverse

		erb :'/continents/show'
	end

end