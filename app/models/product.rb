class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many_attached :images
  validates_presence_of :name, :description, :quantity, :price
  validate :image_check

  enum status: { draft: 0, published: 1, archived: 2 }

  private
  def image_check
    if self.images.attached?
      images.each do |img|
        unless img.content_type.in?(%('image/jpeg image/png'))
          errors.add(:images, "must be png or jpeg")
        end
      end
    end
  end

end
