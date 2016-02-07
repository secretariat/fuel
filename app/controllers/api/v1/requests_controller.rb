require 'json'
class Api::V1::RequestsController < ApplicationController
	def create
		data = {email: 'test', fio: 'test_fio', subject: 'test_subject', message: 'test_message'}
		RequestMailer.send_request(data)
		render :status => 200, :json => {:success => true}
	end
end
