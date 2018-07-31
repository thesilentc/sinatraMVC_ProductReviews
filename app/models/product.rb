class Product < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :reviews
  has_many :users, through: :reviews

  belongs_to :user
end
