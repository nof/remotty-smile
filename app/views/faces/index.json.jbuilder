json.array!(@faces) do |face|
  json.extract! face, :id, :user_id, :image, :smile
  json.url face_url(face, format: :json)
end
