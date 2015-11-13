class Face < ActiveRecord::Base
  belongs_to :user

  scope :order_smile, -> user { where(user: user).order(smile: :desc) }
end
