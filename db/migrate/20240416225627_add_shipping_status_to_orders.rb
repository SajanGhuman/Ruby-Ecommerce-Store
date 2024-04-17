class AddShippingStatusToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :shipping_status, :string
  end
end
