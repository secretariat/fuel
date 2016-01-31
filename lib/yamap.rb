require 'json'

class Hash
  def has_rkey?(search)
    self[keys.detect{ |key| search =~ /#{key}/i }]
  end
end


data = File.read("resp.json")
locations = JSON.parse(data)

regions = {
	"Винниц" => 1,
	"Волынск" => 2,
	"Днепропетр" => 3,
	"Донецк" => 4,
	"Житомир" => 5,
	"Закарпатск" => 6,
	"Запорожск" => 7,
	"Ивано-Фран" => 8,
	"Киев" => 9,
	"Киевск" => 10,
	"Кировоград" => 11,
	"Луганск" => 12,
	"Львов" => 13,
	"Николаев" => 14,
	"Одесс" => 15,
	"Полтавск" => 16,
	"Ровенск" => 17,
	"Сумск" => 18,
	"Тернополь" => 19,
	"Харьковск" => 20,
	"Херсонск" => 21,
	"Хмельницк" => 22,
	"Черкас" => 23,
	"Чернигов" => 24,
	"Черновицк" => 25,
	"Автоном" => 26,
	"Чернив" => 25,
	"Чернев" => 25,
	"Крым" => 26,
	"Луцк" => 2,
	"Ар" => 26,
	"Севаст" => 26,
	"Ровно" => 17,
	"Харьков" => 20,
	"Запорожье" => 7,
	"Ужгород" => 6,
	"Сумы" => 18,
	"Полтава" => 16,
}


locations['features'].each do |feature|
	puts yandex_id = feature['properties']['CompanyMetaData']['id']
	puts address = feature['properties']['CompanyMetaData']['address'].split(',')[0].split(' ')[0]
	puts region_id = regions.has_rkey?(address)
	puts coordinates = feature['properties']['description']
	puts description = feature['geometry']['coordinates']
end


