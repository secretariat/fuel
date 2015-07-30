json.array!(@countries) do |country|
  json.extract! country, :id, :short_name, :long_name
end
