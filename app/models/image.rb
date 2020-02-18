class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item
  validates :image, presence: { message: "を選択してください" }
end
