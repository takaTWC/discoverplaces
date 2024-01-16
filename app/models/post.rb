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

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true

  def save_tags(tags)
    # 現在のタグの関連付けを削除し新しいタグに更新
    self.tags.clear
    # 新規または既存のタグを追加
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      self.tags << tag unless self.tags.include?(tag)
    end
  end

  def save_with_place(address, latitude, longitude)
    # Place テーブルで address を検索
    place = Place.find_or_initialize_by(address: address)

    # 新しい場合、緯度経度を設定
    if place.new_record?
      place.latitude = latitude
      place.longitude = longitude
      place.save
    end

    self.update(place_id: place.id)
  end

  def self.looks(word)
    where("title LIKE ?", "%#{word}%")
  end

  def favorited_by?(user)
    user && favorites.exists?(user_id: user.id)
  end

  def marked_by?(user)
    user && bookmarks.exists?(user_id: user.id)
  end

  #閲覧数
  def view_count_for_user(current_user)
    if current_user
      unless ViewCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, post_id: id)
        current_user.view_counts.create(post_id: id)
      end
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
