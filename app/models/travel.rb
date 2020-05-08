class Travel < ApplicationRecord
  before_save { 
    travel_images.each{ |t_img| t_img.mark_for_destruction if t_img.image.blank? } 
  }

  validates :name, presence: true, length: {maximum: 30 }
  validates :country, presence: true, length: {maximum: 255 }
  validates :prefecture, presence: true, length: {maximum: 255 }
  validates :city, length: {maximum: 255 }
  validate :after_date
  validates :want_to_go, length: {maximum: 255 }
  validates :want_to_do, length: {maximum: 255 }
  
  belongs_to :desk
  has_many :travel_images, dependent: :destroy
  has_many :travel_comments, dependent: :destroy

  has_many :favorites, foreign_key: :travel_id, dependent: :destroy
  has_many :liked_user, through: :favorites, source: :user

  accepts_nested_attributes_for :travel_images, allow_destroy: true

  def self.search(search1, search2, search3)
    return Travel.order(:desk_id).order(:id) if search1.blank? && search2.blank? && search3.blank?
    Travel.where(['(name LIKE ?) AND (country LIKE ?) AND (prefecture LIKE ?)', "%#{search1}%", "%#{search2}%", "%#{search3}%"]).order(:desk_id).order(:id)
  end

  # validates カスタムメソッド
  def after_date
    if (starts_on.blank? || ends_on.blank?)
      return
    else
      if starts_on > ends_on
        errors.add(:starts_on, "Start date is later than end date.")
      end
    end
  end
end