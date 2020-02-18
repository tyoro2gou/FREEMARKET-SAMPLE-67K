class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :description, :status_id, :postage_id, :region_id, :shipping_date_id, :price, presence: true 
  validates :status_id, numericality: { greater_than: 1, message: "を選択してください" } 
  validates :postage_id, numericality: { greater_than: 1, message: "を選択してください" } 
  validates :region_id, numericality: { greater_than: 1, message: "を選択してください" } 
  validates :shipping_date_id, numericality: { greater_than: 1, message: "を選択してください" } 
  validates :category_id, numericality: { greater_than: 1, message: "を選択してください" } 
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
