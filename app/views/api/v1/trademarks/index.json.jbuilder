json.array!(@trademarks) do |trademark|
  json.extract! trademark, :id, :name, :operator_name, :country_id
end
