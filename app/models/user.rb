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

end
