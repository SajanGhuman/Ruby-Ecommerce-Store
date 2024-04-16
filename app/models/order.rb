class Order < ApplicationRecord
  validates :order_id, presence: true, length: { maximum: 255 }
  validates :product_id, presence: true, length: { maximum: 255 }
  validates :book_id, presence: true
  belongs_to :book
  belongs_to :customer
end
