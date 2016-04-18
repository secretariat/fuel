json.array!(@locations) do |location|
  json.extract! location, :id, :address, :region_id, :description, :lat, :long
end
