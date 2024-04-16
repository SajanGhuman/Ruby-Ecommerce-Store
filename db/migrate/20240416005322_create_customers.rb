# db/migrate/YYYYMMDDHHMMSS_create_customers.rb
class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.references :user, foreign_key: true
      t.references :province, foreign_key: true
      t.timestamps
    end
  end
end
