json.array!(@searches) do |search|
  json.extract! search, :id, :user_id, :keyword
  json.url search_url(search, format: :json)
end
