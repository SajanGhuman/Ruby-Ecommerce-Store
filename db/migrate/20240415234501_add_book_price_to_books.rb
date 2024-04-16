class AddBookPriceToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :book_price, :float
  end
end
