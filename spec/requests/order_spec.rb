require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include JwtTokenHelper

  before do
    @user = FactoryBot.create(:user)
    @dish = FactoryBot.create(:dish)
    @token = generate_jwt_token(@user.id)
  end

  describe 'GET #index' do
    it 'should return the all the orders of user with token ' do 
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index
      expect(response).to be_successful
    end

    it 'should not return the all orders without token ' do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  let(:order){FactoryBot.create(:order)}
  describe 'GET #show' do
    it 'should return then specific order of user with token ' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :show ,params: { id: order.id }
      expect(response).to be_successful
    end
  end



end
