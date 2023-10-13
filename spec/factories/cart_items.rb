FactoryBot.define do
  factory :cart_item do
    quantity {"5"}
    dish
    cart
  end
end
