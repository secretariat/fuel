json.array!(@cities) do |city|
  json.extract! city, :id, :name, :lang_id, :country_id, :region_id
  json.url city_url(city, format: :json)
end
