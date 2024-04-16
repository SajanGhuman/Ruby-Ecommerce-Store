class RenameColumnsInOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :user_id, :user
    rename_column :orders, :province_id, :province
  end
end
