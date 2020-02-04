class Address < ApplicationRecord
  belongs_to :user
  validates :postal_code, :prefectures, :municipalities, :address,  presence: true
end
