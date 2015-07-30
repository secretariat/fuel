json.array!(@langs) do |lang|
  json.extract! lang, :id, :name
  json.url lang_url(lang, format: :json)
end
