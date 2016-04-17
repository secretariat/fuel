class RequestMailer < ApplicationMailer
	default to: Proc.new { ['mts@citrusdev.com.ua']}
# 'oil@smartbud.in.ua'] }
	
	def send_request(data)
		@data = data
		mail( :from => "noreply@citrusdev.com.ua", :subject => @data[:subject] )
	end
end
