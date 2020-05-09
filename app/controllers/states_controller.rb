class StatesController < ApplicationController

	get "/states" do
		@states = State.all.sort_by(&:positive).reverse

		erb :'/states/index'
	end

	get "/states/:abbrev" do
		@state = State.find(params[:abbrev])

		erb :"/states/show"
	end

end