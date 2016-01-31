# -*- encoding : utf-8 -*-
require "open-uri"
require "net/http"
require 'json'

def get_azs_petrol
 	@data = "allAZS=false&fuels=1&fuels=2&fuels=3&fuels=30&fuels=47&fuels=44&fuels=33&fuels=32&fuels=38&fuels=20&fuels=43&fuels=51&fuels=45&fuels=14&fuels=12&fuels=13&fuels=31&fuels=39&fuels=21&fuels=42&fuels=6&fuels=4&fuels=5&fuels=27&fuels=36&fuels=7&fuels=10&fuels=11&fuels=37&fuels=9&fuels=41&fuels=35&fuels=18&fuels=17&fuels=26&fuels=19&fuels=46&fuels=34&fuels=15&fuels=16&fuels=22&fuels=23&brends=6&brends=3&brends=84&brends=1&brends=4&brends=9&brends=50&brends=7&brends=35&brends=21&brends=10&brends=5&brends=23&brends=73&brends=31&brends=81&brends=29&brends=16&brends=19&brends=37&brends=53&brends=74&brends=55&brends=83&brends=70&brends=27&brends=46&brends=34&brends=28&brends=60&brends=8&brends=18&brends=52&brends=24&brends=25&brends=26&brends=33&brends=14&brends=61&brends=17&brends=12&brends=82&brends=44&brends=56&brends=57&brends=41&brends=63&brends=43&brends=77&brends=72&brends=59&brends=58&brends=54&brends=80&brends=49&brends=71&brends=64&brends=48&brends=65&brends=68&brends=76&brends=75&brends=69&brends=45&brends=0&price=9.9&price=26.8&azs=&timestamp=1447883375469"
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
	File.write("test", res.body)
	# begin
		puts locations = JSON.parse(res.body)
		# locations = JSON.parse!(eval(res.body))
		# locations = JSON.parse!(res.body.split(',{')[0])
	# rescue Exception => e
		# puts e.message
	# end
end

get_azs_petrol
