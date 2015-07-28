json.array!(@trademarks) do |trademark|
  json.extract! trademark, :id, :name, :operator_name, :lang_id
  json.url trademark_url(trademark, format: :json)
end
