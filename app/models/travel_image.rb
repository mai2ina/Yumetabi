class TravelImage < ApplicationRecord
  belongs_to :travel

  mount_uploader :image, TravelimageUploader
end