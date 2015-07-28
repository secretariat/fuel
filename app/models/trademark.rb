# -*- encoding : utf-8 -*-
class Trademark < ActiveRecord::Base
	def self.get_or_create( tm, opname )
  	trademark = find_by_name( tm )
  	trademark.present? ? trademark.id : create(:name => tm, :operator_name => opname ).id
  end
end
