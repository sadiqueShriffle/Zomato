FactoryBot.define do
  factory :order_item do
    quantity { Faker::Number.decimal_part(digits: 2)}
    dish 
    order
  end
end
