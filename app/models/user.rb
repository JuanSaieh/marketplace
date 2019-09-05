# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :products, dependent: :destroy
  validates_presence_of :first_name, :last_name, :email
  accepts_nested_attributes_for :products, allow_destroy: true

  scope :except_me, ->(id) { where('id != ?', id) }

  def name
    "#{first_name} #{last_name}".titleize
  end

  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_create!({
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      password: Devise.friendly_token[8, 8]
    })
  end
end
