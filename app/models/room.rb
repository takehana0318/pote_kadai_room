class Room < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :name, :description, :price_per_day, :address, presence: true
  validates :price_per_day, numericality: { greater_than_or_equal_to: 1, message: "は1円以上である必要があります" }
end
