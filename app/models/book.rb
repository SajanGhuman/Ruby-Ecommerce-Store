class Book < ApplicationRecord
  validates :book_name, presence: true, length: { maximum: 255 }
  validates :book_desc, presence: true, length: { maximum: 255 }
  validates :book_author, presence: true, length: { maximum: 255 }
  validates :book_genre, presence: true, length: { maximum: 255 }
  validates :book_publisher, presence: true, length: { maximum: 255 }
  validates :book_image, presence: true
  validates :category_id, presence: true
  validates :on_sale, inclusion: { in: [true, false] }

  has_one_attached :book_image
  has_and_belongs_to_many :categories, join_table: :books_categories, foreign_key: :book_id, association_foreign_key: :category_id
  has_one :order

  def self.ransackable_associations(auth_object = nil)
    ["book_image_attachment", "book_image_blob", "categories"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["book_author", "book_desc", "book_image", "book_name", "book_publisher", "category_id", "created_at", "id", "id_value", "updated_at"]
  end

end
