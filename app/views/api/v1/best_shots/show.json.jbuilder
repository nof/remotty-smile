json.array!(@users) do |user|
  json.user do |json|
    json.extract! user, :id, :name, :icon_url
    if face = user.faces.order_smile(user).first and face.image.present?
      json.face do |json|
        json.extract! face, :image_url, :smile
      end
    end
  end
end
