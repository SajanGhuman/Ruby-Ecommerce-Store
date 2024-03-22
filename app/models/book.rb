class Book < ApplicationRecord
    has_one_attached :image
    has_and_belongs_to_many :categories, join_table: :books_categories, foreign_key: :book_id, association_foreign_key: :category_id

    def self.ransackable_attributes(auth_object = nil)
        ["book_author", "book_desc", "book_genre", "book_image", "book_name", "book_publisher", "created_at", "id", "id_value", "updated_at"]
      end

    def self.ransackable_associations(auth_object = nil)
        []
      end

     
  end
  