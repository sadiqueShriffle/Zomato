require 'rails_helper'

RSpec.describe Order, type: :model do
      let!(:subject){
      FactoryBot.create(:order)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without shipping_address"do
    subject.shipping_address = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without total_amount" do
    subject.total_amount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid wihtout unique_order_id" do
    subject.unique_order_id = nil
    expect(subject).to_not be_valid
  end

  it {should belong_to(:user)}
  it {should have_many(:order_items)}
end
