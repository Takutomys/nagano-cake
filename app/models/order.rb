class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, paid_up: 1, production: 2, preparing: 3, shipped: 4 }
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  def sum_of_total_payment
      total + shopping_cost
  end

  def count_amount
    total_amount = 0
    order_details.each do |order_detail|
      total_amount += order_detail.amount
    end
    total_amount
  end
end