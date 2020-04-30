class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :biography, length: {maximum: 255 }
  has_secure_password
  
  mount_uploader :image, ImageUploader

  # フォロー機能のモデル
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

  # お気に入り機能のモデル
  has_many :favorites, dependent: :destroy
  has_many :liked, through: :favorites, source: :travel
  
  # desks を先に持ってくるとアカウント削除の時の関連テーブルの削除が travels->favories になり、
  # favorites の参照レコードがなくなる場合にエラーが出るため、desks は最後に持ってくる
  has_many :desks, dependent: :destroy
  has_many :travel_comments, dependent: :destroy

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def like(travel)
    self.favorites.find_or_create_by(travel_id: travel.id)
  end

  def dislike(travel)
    favorite = self.favorites.find_by(travel_id: travel.id)
    favorite.destroy if favorite
  end

  def is_liked(travel)
    self.liked.include?(travel)
  end

  def self.search(search1)
    return User.all if search1.blank?
    User.where(['(name LIKE ?)', "%#{search1}%"])
  end
end
