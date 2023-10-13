require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject{
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


  it {should belong_to(:user)}
  it {should have_many(:order_items)}

# Callback Testing
  # describe "when order is not save" do
  #   it "generate order_id and calculate total amount" do
  #     order = Order.new
  #     order.unique_order_id.should_receive(:unique_order_id)


  #     self.unique_order_id = SecureRandom.hex(7)
  #     self.total_amount = self.user.cart.cart_items.sum{|cart_item| cart_item.dish.price * cart_item.quantity}
  #   end
  # end
end
