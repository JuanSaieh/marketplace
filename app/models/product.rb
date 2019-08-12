class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :name, :description, :quantity, :price

  enum status: { draft: 0, published: 1, archived: 2 }
end
