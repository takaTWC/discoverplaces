class Place < ApplicationRecord
  has_many :posts

  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
