json.array!(@users) do |user|
  json.id = user.id
  json.icon_url = user.icon_url
end
