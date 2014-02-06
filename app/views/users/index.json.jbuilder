json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :name, :user_group_id
  json.url user_url(user, format: :json)
end
