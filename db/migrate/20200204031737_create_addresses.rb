class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :postal_code, null: false
      t.string :prefectures, null: false
      t.string :municipalities, null: false
      t.string :address, null: false
      t.string :building
      t.timestamps
    end
  end
end
