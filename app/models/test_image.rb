class TestImage < ApplicationRecord
  mount_uploader :image, ImageUploader
end
