class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, limit: 40
      t.text :description, null: false, limit: 1000
      t.integer :status, default: 0, null: false, limit: 1
      t.integer :postage, default: 0, null: false, limit: 1
      t.integer :region, default: 0, null: false, limit: 1
      t.integer :shipping_date, default: 0, null: false, limit: 1
      t.string :price, null: false
      # t.references :category, foreign_key: true
      # t.references :bland, foreign_key: true
      t.timestamps
    end
  end
end
