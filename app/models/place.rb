class Place < ApplicationRecord
  has_many :posts

  validates :address, presence: true
end
