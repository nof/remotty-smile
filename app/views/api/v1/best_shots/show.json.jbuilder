json.array!(@users) do |user|
  json.extract! user, :id, :icon_url
end
