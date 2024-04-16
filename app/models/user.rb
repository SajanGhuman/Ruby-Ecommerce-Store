class User < ApplicationRecord
  pay_customer default_payment_processor: :stripe
  belongs_to :province
  has_one :customer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
