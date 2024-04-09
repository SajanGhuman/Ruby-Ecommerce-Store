class Category < ApplicationRecord
  validates :category_name, presence: true, length: { maximum: 255 }
    has_and_belongs_to_many :books, join_table: :books_categories, foreign_key: :category_id, association_foreign_key: :book_id

    def self.ransackable_associations(auth_object = nil)
        ["books"]
      end

      def self.ransackable_attributes(auth_object = nil)
        ["category_desc", "category_image", "category_name", "created_at", "id", "id_value", "updated_at"]
      end

end
