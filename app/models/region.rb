# -*- encoding : utf-8 -*-
class Region < ActiveRecord::Base

	scope :active, -> { where(:active => true) }

	has_many :prices

	def self.get_or_create_ua( region_name )
  	region = find_by_name( region_name )
  	region.present? ? region.id : create(:name => region_name, :country_id => 233, :lang_id => 1).id
  end
end
