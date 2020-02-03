# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|last_name|string|null: false|
|family_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday_info|string|null: false|
|phone_number|string|
### Association
- has_many :items
- has_many :comments
- has_many :cards
- has_one :addresses

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|postal_code|string|null:false｜
|prefectures|string|null: false|
|municipalities|string|null: false|
|address|string|null: false|
|building|string|
### Association
- belongs_to :user


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foreign_key: true|
|image|string|null: false|
### Association
- belongs_to :item


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|string|null: false|
|status|integer|null: false|
|postage|string|null: false|
|region|string|null: false|
|shopping_data|string|null: false|
|price|string|null: false|
|saler_id|reference|null: false, foreign_key: true|
|buyer_id|reference|null: false, foreign_key: true|
|category_id|reference|null: false, foreign_key: true|
|bland_id|reference|null: false, foreign_key: true|
## Association
- has_many :comments
- has_many :images
- belongs_to :user
- belongs_to :category
- belongs_to :bland


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|integer|null: false|
### Association
- has_many :items
- has_ancestry


## blandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|integer|null: false|
### Association
- has_many :items
- has_ancestry


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|item_id|reference|null: false, foreign_key: true|
|user_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item