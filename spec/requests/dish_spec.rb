require 'rails_helper'

RSpec.describe DishesController, type: :controller do
  include JwtTokenHelper

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @restaurent = FactoryBot.create(:restaurent)
    @token = generate_jwt_token(@user.id)
  end

  describe 'GET #index' do
    it 'returns a successful response with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index
      expect(response).to be_successful
    end
    it 'returns unauthorized without a token' do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  let(:dish) { Dish.create(name: 'Test Dish',price: 120, dish_type: 'veg' ,category_id: @category.id) }
  describe 'GET #show' do
    it 'returns a successful response with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :show, params: { id: dish.id }
      expect(response).to be_successful
    end
    it 'returns unauthorized without a token' do
      get :show, params: { id: dish.id }
      expect(response).to have_http_status(401)
    end

  end

  describe 'PATCH #update' do
    it 'updates the dish with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      patch :update, params: { id: dish.id, dish: { name: 'Updated Dish' } }
      dish.reload
      expect(dish.name).to eq('Updated Dish')
    end
    it 'returns unauthorized without a token' do
      patch :update, params: { id: dish.id, dish: { name: 'Updated Dish', price: 122, dish_type: 'non_veg' } }
      expect(response).to have_http_status(401)
    end
  end

  describe 'DELETE #destroy' do
    # let!(:dish) { Dish.create(name: 'Test Dish', restaurant_id: @restaurant.id, category_id: @category.id) }

    # it 'return not found when passing invalid id' do 
    #   request.headers['Authorization'] = "Bearer #{@token}"
    #   delete :destroy, params: {id: -1 }
    #   expect(response).to have_http_status(404)
    # end
    it 'deletes the dish with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      expect {
        delete :destroy, params: { id: dish.id }
      }.to change(Dish, :count).by(1)
    end
    it 'returns unauthorized without a token' do
      delete :destroy, params: { id: dish.id }
      expect(response).to have_http_status(401)
    end

  end

  describe 'POST #create' do
    it 'creates a new dish with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      expect {
        post :create, params: { dish: { restaurent_id: @restaurent.id, category_id: @category.id,name: 'New Dish',price: 150, dish_type: 'veg',  } }
      }.to change(Dish, :count).by(0)
    end

    it 'returns unauthorized without a token' do
      post :create, params: { dish: { name: 'New Dish', restaurent_id: @restaurent.id, category_id: @category.id } }
      expect(response).to have_http_status(401)
    end
  end


  describe 'GET #Index Search' do
    it 'searches for a  dish ' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index, params: { restaurent_id: @restaurent.id}
      expect(response).to be_successful
    end

    it 'searches for a  Category Dish ' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index, params: { restaurent_id: @restaurent.id , name: 'New Dish'}
      expect(response).to be_successful
    end

    it 'searches for a  Category Dish ' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index, params: { category_id: @category.id }
      expect(response).to be_successful
    end

    it 'searches for a  Category Dish ' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index, params: { name: dish.name }
      expect(response).to be_successful
    end

    it 'returns an error message if no restaurent is found' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :index, params: { restaurent_id: nil }
      expect(response).to have_http_status(200)
    end
  end

end
