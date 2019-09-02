# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]
  has_many :products, dependent: :destroy
  validates_presence_of :first_name, :last_name, :email

  scope :except_me, ->(id) { where('id != ?', id) }

  def name
    "#{first_name} #{last_name}".titleize
  end

  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_create!(
      {
        email: auth.info.email,
        password: Devise.friendly_token[8, 8]
      }.merge(names(auth))
    )
  end

  private

  def self.names(auth)
    is_facebook = auth.provider == 'facebook'
    {
      first_name: is_facebook ? auth.info.name.split.first : auth.info.first_name,
      last_name: is_facebook ? auth.info.name.split.last : auth.info.last_name
    }
  end
end
