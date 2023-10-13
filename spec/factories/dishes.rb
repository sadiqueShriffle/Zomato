FactoryBot.define do
  factory :dish do
        name { "Chinese" }
    price {123}
    # traits_for_enum :dish_type, %w[veg non_veg]

    dish_type {"veg"}
    category
  end
end
