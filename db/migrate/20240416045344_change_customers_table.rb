class ChangeCustomersTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :user, :integer
    remove_column :customers, :province, :integer
    add_reference :customers, :user, foreign_key: true
    add_reference :customers, :province, foreign_key: true
  end
end
