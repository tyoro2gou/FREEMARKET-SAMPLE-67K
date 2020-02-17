class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :description, :price, presence: true 
  validates :status_id, inclusion: { in: %w(0), message: "商品の状態を選択してください" }
  validates :postage_id, inclusion: { in: %w(0), message: "配送料の負担を選択してください" }
  validates :region_id, inclusion: { in: %w(0), message: "発送元の地域を選択してください" }
  validates :shipping_date_id, inclusion: { in: %w(0), message: "発送までの日数を選択してください" }
  has_many :comments
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :images, presence: true
  # itemテーブルにsaler_idとbuyer_idカラムを作ることにした
  # has_many :item_users
  # has_many :users,  through: :item_users
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :category
  # belongs_to :bland
  belongs_to_active_hash :region
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :shipping_date
end
