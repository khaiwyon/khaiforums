class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged]
  has_many :posts
  belongs_to :user
  paginates_per 2

  mount_uploader :image, ImageUploader

  validates :title, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
end
