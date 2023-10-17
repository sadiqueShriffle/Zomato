require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  include JwtTokenHelper

  before(:each) do
    @user = FactoryBot.create(:user)
    @token = generate_jwt_token(@user.id)
    request.headers['Authorization'] = "Bearer #{@token}"
  end

  describe 'GET #show' do
    it 'returns a list of cart items for the current user' do
      get :show
      expect(response).to be_successful
    end
  end

  let!(:dish) { FactoryBot.create(:dish) }
  describe 'POST #add_item' do

    it 'adds an item to the cart for the current user' do
      request.headers['Authorization'] = "Bearer #{@token}"

      post :add_item, params: { cart_item: { dish_id: dish.id, quantity: 2 } }
      expect(response).to have_http_status(200)
    end

    it 'does not add an item with invalid parameters' do
      post :add_item, params: { cart_item: { dish_id: nil, quantity: 2 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  let!(:cart_item) { FactoryBot.create(:cart_item) }
  describe 'PATCH #update' do
    it 'updates the quantity of an item in the cart for the current user' do
      patch :update, params: { cart_item_id: cart_item.id, cart_item: { quantity: 3 } }
      expect(response).to have_http_status(200)
    end

    it 'does not update the item with invalid parameters' do
      patch :update, params: { cart_item_id: cart_item.id, cart_item: { quantity: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    # let!(:cart_item) { @user.cart.cart_items.create(dish_id: 1, quantity: 1) }

    it 'removes an item from the cart for the current user' do
      delete :destroy, params: { cart_item_id: cart_item.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #clear_cart' do
    before do
      3.times {FactoryBot.create(:cart_item) }
    end

    it 'clears all items from the cart for the current user' do
      post :clear_cart
      expect(response).to have_http_status(200)
    end
  end
end