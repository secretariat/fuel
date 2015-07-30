class Api::V1::TrademarksController < ApplicationController
  def index
    @trademarks = Trademark.all
  end
end
