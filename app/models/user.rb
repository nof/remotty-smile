class User < ActiveRecord::Base
  has_many :faces

  def self.find_or_create_with_omniauth(auth)
    user = User.find_or_initialize_by(provider: auth['provider'], uid: auth['uid'].to_s)
    user.token = auth.credentials.token
    if auth['info']
      user.name = auth['info']['name'] || ''
      user.room_key = auth['info']['room_id'] || ''
      user.participation_key = auth['info']['participation_id'] || ''
      user.email = auth['info']['email'] || ''
      user.icon_url = auth['info']['icon_url'] || '/noImage.jpg'
    end
    user.save
    user
  end

  def same_room_snapshots
    parsed = Remotty.access_token(self.token).get('/api/v1/rooms/snapshots').parsed
    snapshots = parsed['participations'].map {|participation| OpenStruct.new(participation) }
    snapshots.select {|snapshot| snapshot.online && snapshot.snapshot_url.present? }
  end

  def self.get_current_faces
    User.find_each do |user|
      before_best_face = user.faces.last

      face = user.faces.new
      face.remote_image_url = user.same_room_snapshots.select{|struct| struct.user_id == user.uid.to_i }.first.snapshot_url
      face.save

      face.smile = 0.99 #user.detect_smile(face.image.url.sub(/\?.+$/, ''))

      if before_best_face.smile > face.smile
        face.destroy
      else
        before_best_face.destroy
        face.save
      end
    end
  end

  def detect_smile(image_url)

    encoded_url = ERB::Util.url_encode image_url
    api_url = "https://apius.faceplusplus.com/v2/detection/detect?url=#{encoded_url}&api_secret=#{Rails.application.secrets.fpp_api_secret}&api_key=#{Rails.application.secrets.fpp_api_key}&attribute=glass,pose,gender,age,race,smiling"

    json = ::RestClient.get api_url do |response, request, result, &block|
      case response.code
      when 200
        puts response.body
        JSON.parse(response.body)
      else
        nil
      end
    end
    json.try(:[], 'face').try(:[], 0).try(:[], 'attribute').try(:[], 'smiling').try(:[], 'value')
  end
end
