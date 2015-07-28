json.array!(@countries) do |country|
  json.extract! country, :id, :iso2, :short_name, :long_name, :iso3, :numcode, :un_member, :calling_code, :cctld
  json.url country_url(country, format: :json)
end
