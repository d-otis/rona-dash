class ApplicationController < Sinatra::Base
	# include API

	# API.new.start

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
	end

	get '/' do 
		redirect to '/countries'
	end

	get '/global' do
		@title = "Global"
		@globals = Country.global_hash

		erb :'global/global'
	end

	get "/refresh" do
		Country.all.clear
		Continent.all.clear
		API.new.start

		redirect "/"
	end

	get "/search" do
		search_term = params[:q].downcase
		if Country.find_by_slug(search_term)
			@country = Country.find_by_slug(search_term)
			@title = "Search Results for \"#{search_term}\""
			erb :'/countries/show'
		else
			@error = "Not found!"
		end		
	end

	get "/about" do
		@title = "About"
		erb :"about"
	end

	helpers do
		def continents
			@continents ||= Continent.all
		end
	end
end