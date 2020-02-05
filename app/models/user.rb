class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :family_name, :last_name, :family_name_kana, :last_name_kana, :birthday_info, presence: true
  has_one :address, dependent: :destroy
end
