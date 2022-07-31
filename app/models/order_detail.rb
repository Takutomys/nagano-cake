class OrderDetail < ApplicationRecord
  enum making_status: { impossible: 0, waiting: 1, production: 2, completed: 3 }

  belongs_to :order
  belongs_to :item
end
