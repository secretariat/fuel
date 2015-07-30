# -*- encoding : utf-8 -*-
class Country < ActiveRecord::Base
	has_many :prices

	scope :active, -> { where(:active => true) }
end
