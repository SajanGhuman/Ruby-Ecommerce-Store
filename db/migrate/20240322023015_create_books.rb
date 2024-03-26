class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :book_desc
      t.string :book_author
      t.string :book_genre
      t.string :book_publisher
      t.string :book_image
      
      t.timestamps
    end
  end
end
