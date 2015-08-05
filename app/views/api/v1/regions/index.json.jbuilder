json.array!(@regions) do |region|
  json.extract! region, :id, :name, :lang_id, :country_id
end
