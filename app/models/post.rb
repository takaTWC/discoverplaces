class Post < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_many :favorites, dependent: :destroy
  has_many :watch_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, through: :tag_relations
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
