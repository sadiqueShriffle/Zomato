require 'rails_helper'

RSpec.describe Restaurent, type: :model do
    subject {
      FactoryBot.create(:restaurent)
          }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a place" do
    subject.place = nil
    expect(subject).to_not be_valid
  end

  describe '#name, status and place  presnese validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:place) }
    it { is_expected.to validate_presence_of(:status) }
  end

# Association Validation
  describe 'associations' do
    it {should have_many(:categories)}
    it {should belong_to(:user)}
    it {should have_many(:dishes).through(:categories)}
  end
end
