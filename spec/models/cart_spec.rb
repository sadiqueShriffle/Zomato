require 'rails_helper'

RSpec.describe Cart, type: :model do
subject{
  FactoryBot.create(:cart)
  }

  it {should belong_to(:user)}
end
