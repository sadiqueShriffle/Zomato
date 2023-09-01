class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    has_many :dishes, through: :cart_items

    
    # accepts_nested_attributes_for :cart_items, allow_destroy: true


    validate :customer_only_add_restaurent

    private
    def customer_only_add_restaurent
        unless user.type == "Customer"
            errors.add(:base, "Only Customer have permission to add Dishes.")      
        end
    end
end
