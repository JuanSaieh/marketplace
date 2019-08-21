class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_one_attached :avatar
  validate :image_check

  def image_check
    if self.avatar.attached? && !self.avatar.content_type.in?(%('image/jpeg image/png'))
      errors.add(:images, "must be png or jpeg")
    end
  end

end
