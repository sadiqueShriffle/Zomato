class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :dish

  validates :quantity, numericality: { grater_than_or_equal_to: 1}
  
end
