# spec/factories/users.rb
FactoryBot.define do
  
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    # trait :owner do
    # type { 'owner' } # If you have different user types
    # end
    type { 'Customer' } # Adjust based on your user types
  end
end