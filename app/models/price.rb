# -*- encoding : utf-8 -*-
require "nokogiri"
require "open-uri"
require "net/http"
require "json"

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

					next if td[0].text.size == 0

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


	def self.get_lpg_alt
		init = open( "http://igas.com.ua/#date=2015-08-11&area=2&station=average" )
		page = Nokogiri::HTML(init.read)
		key = page.at('input[@type="hidden"]')['name']
		value = page.at('input[@type="hidden"]')['value']
		cookie = init.meta['set-cookie'].split('; ', 2)[0]
		uri = URI.parse("http://igas.com.ua/ajax/get_fuel.json")

		2.upto(26) do |region_id|
			area = (region_id >= 11) ? (region_id - 1) : region_id

			r_id = Region.find(region_id).id
			data = "date=2015-08-11&area=#{area}&station=average&#{key}=#{value}"

			req = Net::HTTP::Post.new(uri.path)
			req.add_field('Cookie', cookie)
			req.add_field('X-Requested-With', "XMLHttpRequest")
			req.body = data

			res = Net::HTTP.start(uri.hostname, uri.port) do |http|
	  		http.request(req)
			end

			js = JSON.parse(res.body)
			price_blocks = js['message'].values[0]
			lpg_tm_id = 0
			lpg_price = 0.0
			price_blocks.each do |pb|
				pb['brand_name'] = "KLO" if pb['brand_name'] == "КЛО"
				pb['brand_name'] = "Avantage 7" if pb['brand_name'] == "Авантаж 7"
				if lpg_tm = Trademark.where("name LIKE ?", "%#{pb['brand_name'].split(" ")[0]}%").first
					lpg_tm_id = lpg_tm.id
				end
				lpg_price = eval(pb['price_fuel'].gsub(":","=>"))['gas']
				price = {
								:country_id => 233,
								:region_id => r_id,
								:city_id => 0,
								:trademark_id => lpg_tm_id,
								:fuel_type_id => 6,
							}
				obj = Price.where(price)
				price[:cost] = '%.2f' % lpg_price
				obj.update_or_create( price )
			end
		end

	end
end
