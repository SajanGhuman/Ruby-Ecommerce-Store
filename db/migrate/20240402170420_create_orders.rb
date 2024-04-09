class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :product_id
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
