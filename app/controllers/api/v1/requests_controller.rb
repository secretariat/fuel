require 'json'
class Api::V1::RequestsController < ApplicationController
	def create
    data = JSON.parse(params[:message])
#		data = {email: 'test', fio: 'fio', subject: 'subject', message: 'message'}
		RequestMailer.send_request(data).deliver
		render :status => 200, :json => {:success => true}
	end
end
