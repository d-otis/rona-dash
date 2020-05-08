class CountriesController < ApplicationController

	get '/countries/:slug' do
		@title = params[:slug].capitalize
		@country = Country.find_by_slug(params[:slug])

		erb :'/countries/show'
	end

	get '/countries' do
		@title = "Countries"
		@countries = Country.all.sort_by(&:cases).reverse

		erb :'/countries/index'
	end
end