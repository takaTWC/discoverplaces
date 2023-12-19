class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  #フォロー時相互関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #一覧
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower

  validates :name, presence: true
  validates :introduction, presence: true

  GUEST_USER_EMAIL = "guest@example.com"

  # アイコン画像がない場合
  def display_image
    image.attached? ? image : 'Noimage.jpg'
  end
  
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "GuestUser"
      user.introduction = "We look forward to your registration!"
      file_path = Rails.root.join('app/assets/images/guest_user.png')
      user.image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
  end

  #フォローする時
  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  #フォローを外すとき
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  #フォロー時にtrue
  def following?(user)
    following_users.include?(user)
  end
end
