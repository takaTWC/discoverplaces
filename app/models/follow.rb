class Follow < ApplicationRecord
  has_many :follow_relations, dependent: :destroy
  has_many :users, through: :follow_relations
end
