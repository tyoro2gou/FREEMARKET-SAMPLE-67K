class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :family_name, :last_name, :family_name_kana, :last_name_kana, :birthday_info, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  has_one :address, dependent: :destroy
  validates :password, presence: true, length: { minimum: 7 }
  VALID_ZENKAKU_REGEX = /\A[ぁ-んァ-ン一-龥]/
  validates :family_name, :last_name, :family_name_kana, :last_name_kana, format: { with: VALID_ZENKAKU_REGEX}
  # https://qiita.com/takeoverjp/items/bb56d6a8eae191cd3732
  # has_many :buyer_item_users, class_name: 'ItemUsers', :foreign_key => 'buyer_id'
  # has_many :seller_item_users, class_name: 'ItemUsers', :foreign_key => 'saler_id'
  # itemテーブルにsaler_idとbuyer_idカラムを作ることにした
  # has_many :item_users
  # has_many :items,  through: :item_users
  has_many :items
  has_many :comments
  has_many :cards
end
