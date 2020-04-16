class Desk < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :overview, length: { maximum: 255 }
  
  belongs_to :user
  has_many :travels, dependent: :destroy
end
