# -*- encoding : utf-8 -*-
class Api::V1::LocationsController < ApplicationController
	def index
		@locations = Location.where(:trademark => params[:trademark_id])
	end
end
