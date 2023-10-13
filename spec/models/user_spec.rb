require 'rails_helper'

RSpec.describe User, type: :model do
 # subject { User.new(name: "Jack", email: "jsmith@sample.com" ,type: "Owner",password: '123456', password_confirmation: '123456')}

 subject {
   FactoryBot.create(:user )
  }

  # subject{
  # FactoryBot.create(:user,type: FactoryBot.create(:user,type: "Owner").type)
  # }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end


    # it "is not valid without a type" do
    #   subject.type = nil
    #   expect(subject).to_not be_valid
    # end


    #Validations
    describe '#name and email presnese validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
    end


    # Association Validation
    describe 'associations' do
      it{should have_many(:restaurents)}
      it{should have_many(:categories)}
      it{should have_many(:dishes).through(:categories)}
      it{should have_one(:cart)}
      it{should have_many(:cart_items).through(:cart)}
      it{should have_many(:orders)}
      it{should have_many(:order_items).through(:orders)}
    end

end
