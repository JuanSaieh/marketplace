class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images, as: :imageable, dependent: :destroy
  validates_presence_of :name, :description, :quantity, :price
  accepts_nested_attributes_for :images, allow_destroy: true

  enum status: { draft: 0, published: 1, archived: 2 }
end
