class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :comments
  belongs_to :topic
  belongs_to :user

  mount_uploader :image, ImageUploader
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  before_save :summon_slug

private

  def summon_slug
    self.slug = title if self.slug != title
  end
end
