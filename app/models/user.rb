class User < ApplicationRecord
  has_many :products, dependent: :destroy
  validates_presence_of :first_name, :last_name, :email

end
