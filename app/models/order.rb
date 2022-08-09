class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, paid_up: 1, production: 2, preparing: 3, shipped: 4 }

  belongs_to :customer
  has_many :order_detail, dependent: :destroy
end