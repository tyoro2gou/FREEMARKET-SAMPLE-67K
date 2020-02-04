class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments
  has_many :images
  has_many :item_users
  has_many :users,  through: :item_users
  belongs_to :category
  # belongs_to :bland
  belongs_to_active_hash :region
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :shipping_date
end
