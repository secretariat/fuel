# -*- encoding : utf-8 -*-
class Trademark < ActiveRecord::Base

	has_many :prices

	# scope :active, -> { where(:active => true) }

	def self.get_or_create_ua( tm, opname )
  	trademark = find_by_name( tm )
  	trademark.present? ? trademark.id : create(:name => tm, :operator_name => "", :country_id => 233 ).id
  end
end
