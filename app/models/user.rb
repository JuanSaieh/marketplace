# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  validates_presence_of :first_name, :last_name, :email
  accepts_nested_attributes_for :products, allow_destroy: true

  scope :except_me, ->(id) { where('id != ?', id) }

  def name
    "#{first_name} #{last_name}".titleize
  end
end
