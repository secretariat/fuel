# -*- encoding : utf-8 -*-
require "open-uri"
require "net/http"
require 'json'


class Hash
  def has_rkey?(search)
    self[keys.detect{ |key| search =~ /#{key}/i }]
  end
end

class Location < ActiveRecord::Base
	belongs_to :region
	belongs_to :trademark
	
	@regions = { 
							"Винниц" => 1, "Волынск" => 2, "Днепропетр" => 3,
							"Донецк" => 4, "Житомир" => 5, "Закарпатск" => 6,
							"Запорожск" => 7, "Ивано-Фран" => 8, "Киев" => 9,
							"Киевск" => 10,  "Кировоград" => 11, "Луганск" => 12,
							"Львов" => 13,  "Николаев" => 14, "Одесс" => 15,
							"Полтавск" => 16, "Ровенск" => 17, "Сумск" => 18,
							"Тернополь" => 19, "Харьк" => 20, "Херсонск" => 21,
							"Хмельницк" => 22, "Черкас" => 23, "Чернигов" => 24,
							"Черновицк" => 25, "Автоном" => 26, "Чернив" => 25,
							"Чернев" => 25, "Крым" => 26, "Луцк" => 2,
							"Ар" => 26, "Севаст" => 26, "Ровно" => 17,
							"Харьков" => 20, "Запорожье" => 7, "Ужгород" => 6,
							"Сумы" => 18, "Полтава" => 16, "Рівен" => 17
						}


 	@data = "allAZS=false&fuels=1&fuels=2&fuels=3&fuels=30&fuels=47&fuels=44&fuels=33&fuels=32&fuels=38&fuels=20&fuels=43&fuels=51&fuels=45&fuels=14&fuels=12&fuels=13&fuels=31&fuels=39&fuels=21&fuels=42&fuels=6&fuels=4&fuels=5&fuels=27&fuels=36&fuels=7&fuels=10&fuels=11&fuels=37&fuels=9&fuels=41&fuels=35&fuels=18&fuels=17&fuels=26&fuels=19&fuels=46&fuels=34&fuels=15&fuels=16&fuels=22&fuels=23&brends=6&brends=3&brends=84&brends=1&brends=4&brends=9&brends=50&brends=7&brends=35&brends=21&brends=10&brends=5&brends=23&brends=73&brends=31&brends=81&brends=29&brends=16&brends=19&brends=37&brends=53&brends=74&brends=55&brends=83&brends=70&brends=27&brends=46&brends=34&brends=28&brends=60&brends=8&brends=18&brends=52&brends=24&brends=25&brends=26&brends=33&brends=14&brends=61&brends=17&brends=12&brends=82&brends=44&brends=56&brends=57&brends=41&brends=63&brends=43&brends=77&brends=72&brends=59&brends=58&brends=54&brends=80&brends=49&brends=71&brends=64&brends=48&brends=65&brends=68&brends=76&brends=75&brends=69&brends=45&brends=0&price=9.9&price=26.8&azs=&timestamp=1447883375469"

	def self.get_points(trademark)
		
		source = "https://search-maps.yandex.ru/v1/?text=\"АЗС #{trademark.name}\"&type=biz&lang=ru_RU&results=1000&ll=26.813995143182623,48.80256086458314&spn=33.0908203125,12.010880536889303&apikey=82e75164-f557-47a6-a818-ef5fbf4a32ae"
		escaped_url = URI.escape(source)
		# resp = Net::HTTP.get_response(URI.parse(escaped_url))
		# data = resp.body
		# locations = JSON.parse(data)

		uri = URI.parse(escaped_url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		locations = JSON.parse(response.body)

		locations['features'].each do |location|
			loc = {}
			loc[:yandex_id] = location['properties']['CompanyMetaData']['id']
			loc[:address] = location['properties']['CompanyMetaData']['address']
			puts location['properties']['CompanyMetaData']['name']
			region_name = location['properties']['CompanyMetaData']['address'].split(',')[0].split(' ')[0]
			loc[:region_id] = @regions.has_rkey?(region_name)
			loc[:trademark_id] = trademark.id
			loc[:description] = location['properties']['description']
			loc[:coordinates] = location['geometry']['coordinates'].join(",")
			loc[:lat] = location['geometry']['coordinates'][0]
			loc[:long] = location['geometry']['coordinates'][1]
			puts(loc)
			Location.create(loc) if loc[:region_id]
		end

	end

	def self.get_stations
		Trademark.all.each do |tm|
			get_points(tm)
			# break
		end
	end


	def self.get_azs_petrol
		uri = URI.parse "http://www.azs.uapetrol.com/cgi-bin/_getAZS.pl"
		req = Net::HTTP::Post.new(uri.path)
		cookie = "__utmt=1; _ym_uid=1447883053643716284; _ym_visorc_10722997=w; UkrAZS_SID=4d1661686c4df8d88bd70283f6baae9b; __utma=49234294.42587217.1447883051.1447883051.1447883051.1; __utmb=49234294.4.10.1447883051; __utmc=49234294; __utmz=49234294.1447883051.1.1.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); fuelsTreeSaveStateCookie=undefined"
		req.add_field('Cookie', cookie)
		req.add_field('X-Requested-With', "XMLHttpRequest")
		req.add_field('Content-Length', @data.length)
		req.body = @data

		res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  		http.request(req)
		end

		
		begin
			locations = JSON.parse(eval(res.body.force_encoding('utf-8')).to_json)['data']
		rescue Exception => e  
			puts e.message
		end

		locations.each do |location|
			puts location
		end
	end

end
