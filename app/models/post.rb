class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user, optional: true
  belongs_to :place, optional: true
  has_many :favorites, dependent: :destroy
  has_many :watch_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_relations
  has_many :tags, through: :tag_relations, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tags(tags)
    #タグが存在すれば取得する
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #既存タグ
    old_tags = current_tags - tags
    #新規タグ
    new_tags = tags - current_tags
    #重複するタグを削除
    old_tags.each do |old_name|
      self.workout_tags.delete Tag.find_by(name:old_name)
    end
    #新規タグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end

  def self.looks(word)
    where("title LIKE ?", "%#{word}%")
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def listed_by?(user)
    watch_lists.exists?(user_id: user.id)
  end
end
