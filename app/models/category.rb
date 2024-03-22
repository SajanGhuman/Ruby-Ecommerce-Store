class Category < ApplicationRecord
    has_and_belongs_to_many :books, join_table: :books_categories, foreign_key: :category_id, association_foreign_key: :book_id
end
