# -*- encoding : utf-8 -*-
require "nokogiri"
require "open-uri"
class Price < ActiveRecord::Base

	def self.get_price_ua
		html = open("http://index.minfin.com.ua/fuel/detail.php")
		page = Nokogiri::HTML(html.read)
		page.encoding = 'utf-8'
		rows = page.css("tr")
		region = ""
		start_parsing = false

		rows.each do |row|
			row.css("th").each do |th|
				if th['colspan']
					region = th.text
					start_parsing = true
				end
			end

			if start_parsing
				td = row.css("td")
				unless td[0].nil?

					region_id = Region.get_or_create_ua( region )
					tm_id = Trademark.get_or_create( td[0].text, td[1].text )
					Price.update_or_create( :country_id => 233, :region_id => region_id, :city_id => 0, :trademark_id => tm_id, :fuel_type_id => 1, :cost => td[2].text )
					Price.update_or_create( :country_id => 233, :region_id => region_id, :city_id => 0, :trademark_id => tm_id, :fuel_type_id => 2, :cost => td[3].text )
					Price.update_or_create( :country_id => 233, :region_id => region_id, :city_id => 0, :trademark_id => tm_id, :fuel_type_id => 3, :cost => td[4].text )
					Price.update_or_create( :country_id => 233, :region_id => region_id, :city_id => 0, :trademark_id => tm_id, :fuel_type_id => 4, :cost => td[5].text )
					Price.update_or_create( :country_id => 233, :region_id => region_id, :city_id => 0, :trademark_id => tm_id, :fuel_type_id => 5, :cost => td[6].text )
					Price.update_or_create( :country_id => 233, :region_id => region_id, :city_id => 0, :trademark_id => tm_id, :fuel_type_id => 6, :cost => td[7].text )

				end
			end
		end
	end

	def self.update_or_create(attributes)
	  assign_or_new(attributes).save
	end

	def self.assign_or_new(attributes)
	  obj = first || new
	  obj.assign_attributes(attributes)
	  obj
	end
end
