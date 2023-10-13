FactoryBot.define do
    
  factory :restaurent do
    name { "indori Taste" }
    place { "indore" }
    # traits_for_enum :status, %w[open close]
    status {"open"}
    user
  end
  end

