class User < ActiveRecord::Base

  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password

  has_many :reviews
  has_many :products, through: :reviews

end
