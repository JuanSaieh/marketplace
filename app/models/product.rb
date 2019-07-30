class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :name, :description, :quantity, :price
end
