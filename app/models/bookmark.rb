class Bookmark < ApplicationRecord
  has_many :bookmark_relations, dependent: :destroy
  has_many :users, through: :bookmark_relations
end
