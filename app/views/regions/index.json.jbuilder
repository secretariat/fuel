json.array!(@regions) do |region|
  json.extract! region, :id, :name, :lang_id, :country_id
  json.url region_url(region, format: :json)
end
