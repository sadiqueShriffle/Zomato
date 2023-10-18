require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include JwtTokenHelper
  
  let!(:user){FactoryBot.create(:user)}
  # let(:cart){FactoryBot.create_cart(user_id: user.id)}
  # let(:cart_item){FactoryBot.create(:cart_item , cart_id: cart.id)}
  let(:order){FactoryBot.create(:order)}
  
  before(:each) do
    @token = generate_jwt_token(user.id)
    request.headers['Authorization'] = "Bearer #{@token}"
  end

 
  describe 'GET #index' do
    it 'returns a list of orders for the current user' do
      get :index
      expect(response).to be_successful
    end

    it 'returns an error message if no orders are found' do
      user.orders.destroy_all
      get :index
      expect(response.body).to eq('No Orders yet')
    end
  end

  # describe 'GET #show ' do
  #       it 'returns a specific order of the current user' do
  #       byebug
  #     get :show, params: {id: order.id}
  #     expect(response).to be_successful
  #   end
  # end

  # let(:order){FactoryBot.create(:order)}
  # describe 'GET #show' do
  #   it 'returns a specific order for the current user' do
  #     get :show, params: { id: order.id }
  #     expect(response).to be_successful
  #   end
  # end

  describe 'POST #create' do

    let(:cart){FactoryBot.create(:cart,user_id: user.id)}
    let(:cart_item){FactoryBot.create!(:cart_item,cart_id: cart.id)}

    it 'creates a new order for the current user' do
      byebug
      post :create, params: { name: 'New Order', shipping_address: 'New Address' }
      expect(response).to have_http_status(201)
    end

    it 'does not create a new order with invalid parameters' do
      post :create, params: { name: nil, shipping_address: 'New Address' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # describe 'PATCH #update' do
  #   let!(:order) { @user.orders.create(name: 'Test Order', shipping_address: 'Test Address') }

  #   it 'updates an order for the current user' do
  #     patch :update, params: { id: order.id, name: 'Updated Order', shipping_address: 'Updated Address' }
  #     expect(response).to be_successful
  #   end

  #   it 'does not update an order with invalid parameters' do
  #     patch :update, params: { id: order.id, name: nil, shipping_address: 'Updated Address' }
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   let!(:order) { @user.orders.create(name: 'Test Order', shipping_address: 'Test Address') }

  #   it 'deletes an order for the current user' do
  #     delete :destroy, params: { id: order.id }
  #     expect(response).to have_http_status(200)
  #   end
  # end
end