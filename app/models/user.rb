class User < ApplicationRecord
  has_secure_password
  has_many :topics
  has_many :posts
  has_many :comments
  has_many :votes
  enum role: [:user, :moderator, :admin]

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
end
