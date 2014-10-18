json.array!(@posts) do |post|
  json.extract! post, :id, :author_id, :title, :body, :tags
  json.url post_url(post, format: :json)
end
