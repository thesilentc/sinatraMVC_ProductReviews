class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :products
  has_many :reviews, through: :products

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end


end
