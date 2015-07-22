require "nokogiri"
require "open-uri"
require "./lib/configer"
require "./lib/model/price"

Configer.new.connect

page = Nokogiri::HTML(open("http://index.minfin.com.ua/fuel/detail.php"))

rows = page.css("tr")

rows.each do |row|
	row.css("td").each do |td|
		puts td.text
		# Price.create( :country_id => 1, :region_id => 1, :city_id => 1, :station_id => (rand(10)), :price => "вставь сюда нужный td" )
	end
end
