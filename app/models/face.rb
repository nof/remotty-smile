class Face < ActiveRecord::Base
  belongs_to :user
  
  mount_uploader :image, FaceUploader

  scope :order_smile, -> user { where(user: user).order(smile: :desc) }
end
