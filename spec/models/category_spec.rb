require 'rails_helper'

RSpec.describe Category, type: :model do
  
  subject{
      FactoryBot.create(:category)
         }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe 'associations' do
    it {should have_many(:dishes)}
    it {should belong_to(:restaurent)}
  end
end
