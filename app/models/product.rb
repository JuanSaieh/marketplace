class Product < ApplicationRecord
  validates_presence_of :name, :description, :quantity, :price
end
