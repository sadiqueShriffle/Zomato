FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    shipping_address { Faker::Address.full_address }
    total_amount {Faker::Number.number(digits: 4)}
    # unique_order_id {Faker::Number.hexadecimal(digits: 7) }
    unique_order_id {"0ac5e46f59260b"}
    user
end
end
