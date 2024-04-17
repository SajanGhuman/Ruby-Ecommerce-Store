class Order < ApplicationRecord
  enum status: { pending: 0, paid: 1, shipped: 2 }

  def self.ransackable_associations(auth_object = nil)
    ["book", "customer"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "customer_id", "id", "id_value", "order_id", "payment_id",
     "product_id", "province", "shipping_status", "status", "updated_at", "user"]
  end

  belongs_to :book
  belongs_to :customer
end
