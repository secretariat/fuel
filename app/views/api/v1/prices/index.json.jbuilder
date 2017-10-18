json.array!(@prices) do |price|
  json.extract! price, :id, :country_id, :region_id, :city_id, :trademark_id, :fuel_type_id, :cost, :updated_at
end
