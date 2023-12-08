class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  has_many :posts, through: :tag_relations, dependent: :destroy
end
