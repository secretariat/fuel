# -*- encoding : utf-8 -*-
class Region < ActiveRecord::Base
	def self.get_or_create_ua( region_name )
  	region = find_by_name( region_name )
  	region.present? ? region.id : create(:name => region_name, :country_id => 233).id
  end
end
