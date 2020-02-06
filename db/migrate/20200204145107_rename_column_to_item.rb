class RenameColumnToItem < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :status, :status_id
    rename_column :items, :postage, :postage_id
    rename_column :items, :region, :region_id
    rename_column :items, :shipping_date, :shipping_date_id
  end
end
