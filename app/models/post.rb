class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user, optional: true
  belongs_to :place, optional: true
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_relations
  has_many :tags, through: :tag_relations, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  accepts_nested_attributes_for :place

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

  def marked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  #閲覧数
  def view_count_for_user(current_user)
    unless ViewCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, post_id: id)
      current_user.view_counts.create(post_id: id)
    end
  end

  #いいねランキング
  def self.post_favorite_ranks
    joins(:favorites)
      .group(:id)
      .order('COUNT(favorites.post_id) DESC')
  end

  #閲覧数ランキング
  def self.post_view_counts_ranks
    joins(:view_counts)
      .group(:id)
      .order('COUNT(view_counts.post_id) DESC')
  end
end
