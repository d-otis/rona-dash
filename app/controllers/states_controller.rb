class StatesController < ApplicationController

	get "/states" do
		@title = "US States"
		@states = State.all.sort_by(&:positive).reverse

		erb :'/states/index'
	end

	get "/states/:abbrev" do
		@state = State.find(params[:abbrev])
		@title = @state.name

		erb :"/states/show"
	end

end