class Topic < ApplicationRecord
  has_many :posts
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
end
