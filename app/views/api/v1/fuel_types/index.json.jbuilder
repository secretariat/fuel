json.array!(@fuel_types) do |fuel_type|
  json.extract! fuel_type, :id, :name
  json.url fuel_type_url(fuel_type, format: :json)
end
