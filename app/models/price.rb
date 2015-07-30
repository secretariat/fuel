# -*- encoding : utf-8 -*-
require "nokogiri"
require "open-uri"

class Price < ActiveRecord::Base

	belongs_to :country
	belongs_to :city
	belongs_to :region
	belongs_to :trademark
	belongs_to :fuel_type

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
					tm_id = Trademark.get_or_create_ua( td[0].text, td[1].text )

					1.upto(6) do |n|
						price = {
							:country_id => 233,
							:region_id => region_id,
							:city_id => 0,
							:trademark_id => tm_id,
							:fuel_type_id => n,
						}
						obj = Price.where(price)
						cost =  td[n+1].text.size > 0 ? td[n+1].text.gsub!(",",".") : 0
						price[:cost] = '%.2f' % cost
						obj.update_or_create( price )
					end
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
