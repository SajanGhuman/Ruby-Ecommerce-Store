class User < ApplicationRecord
  pay_customer default_payment_processor: :stripe
  belongs_to :province
  has_one :customer

  def create_customer
    Customer.create(user: self)
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
