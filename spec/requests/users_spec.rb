require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include JwtTokenHelper

  before(:each) do
    @user = FactoryBot.create(:user)
    @token = generate_jwt_token(@user.id)
  end

  describe 'GET #show' do
    it 'returns a successful response with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :show
      expect(response).to have_http_status(200)
    end

    it 'returns unauthorized without a token' do
      get :show
      expect(response).to have_http_status(401)
    end
  end

  describe 'PATCH #update' do
    it 'updates the user with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      patch :update, params: { id: @user.id, user: { name: 'updated_name' } }
      @user.reload
      expect(@user.name).to eq('Updated Name')
    end

    it 'returns unauthorized without a token' do
      patch :update, params: { id: @user.id, user: { name: 'updated_name' } }
      expect(response).to have_http_status(401)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user with a valid token' do
      request.headers['Authorization'] = "Bearer #{@token}"
      expect {
        delete :destroy, params: { id: @user.id }
      }.to change(User, :count).by(-1)
    end

    it 'returns unauthorized without a token' do
      delete :destroy, params: { id: @user.id }
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      expect {
        post :create, params: { user: { name: 'New User', email: 'newuser@example.com', type: 'Customer', password: '123456' } }
      }.to change(User, :count).by(0)
      expect(response).to have_http_status(200)
    end
  end
end
