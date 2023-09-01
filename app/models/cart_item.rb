class CartItem < ApplicationRecord
    belongs_to :cart 
    belongs_to :dish
    # belongs_to :order, optional: true
    
    validates :quantity, numericality: {greater_than: 0}
end
