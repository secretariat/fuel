json.array!(@fuel_types) do |fuel_type|
  json.extract! fuel_type, :id, :name
end
