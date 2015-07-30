# -*- encoding : utf-8 -*-
class FuelType < ActiveRecord::Base

	has_many :prices

	def self.get_or_create( login_name )
  	login = find_by_login( login_name )
  	login.present? ? login.id : create(:login => login_name).id
  end
end
