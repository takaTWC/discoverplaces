class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user, optional: true
  belongs_to :place, optional: true
  has_many :favorites, dependent: :destroy
  has_many :watch_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, through: :tag_relations, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
