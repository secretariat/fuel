class Api::V1::TrademarksController < ApplicationController
  def index
    @trademarks = Trademark.where(:country_id => params[:country_id])
  end

end
