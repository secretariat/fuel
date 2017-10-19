json.array!(@prices) do |price|
  # json.extract! price, :id, :country_id, :region_id, :city_id, :trademark_id, :fuel_type_id, :cost, :updated_at
  json.id price.id
  json.country_id price.country_id
  json.region_id price.region_id
  json.city_id price.city_id
  json.trademark_id price.trademark_id
  json.fuel_type_id price.fuel_type_id
  json.cost price.cost
  json.updated_at price.updated_at.to_i
end
