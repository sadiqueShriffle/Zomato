require 'rails_helper'

RSpec.describe RestaurentsController, type: :controller do
  include JwtTokenHelper

  before(:each) do
    @user = FactoryBot.create(:user)
    @token = generate_jwt_token(@user.id)
    request.headers['Authorization'] = "Bearer #{@token}"
  end

  # describe 'GET #index' do
  #   byebug
  #   if @user.owner?
  #   it 'returns a list of restaurents for the current owner' do
  #     get :index
  #     expect(response).to be_successful
  #   end
  #   else
  #     it 'returns a list of open restaurents for customers' do
  #       get :index
  #       expect(response).to  have_http_status(200)
  #     end
  #   end
  # end

  describe 'GET #index' do 
    it 'returns a list of all restaurents for the owner' do
      get :index
      expect(response).to be_successful
    end
  end


  describe 'GET #show' do
    # restaurent =@user.FactoryBot.create(:restaurent)
    let!(:restaurent) { @user.restaurents.create(name: 'Test restaurent', status: 'open', place: 'indore') }
    it 'returns a specific restaurent for the current owner' do
      # @user.update(owner: true)
      get :show, params: { id: restaurent.id }
      expect(response).to be_successful
    end

    it 'returns a specific restaurent for customers' do
      # @user.update(owner: false)
      get :show, params: { id: restaurent.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new restaurent' do
      post :create, params: { restaurent: { name: 'New restaurent', place: 'New Place', status: 'open' } }
      expect(response).to have_http_status(200)
    end

    it 'does not create a new restaurent with invalid parameters' do
      post :create, params: { restaurent: { name: nil, place: 'New Place', status: 'open' } }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  let!(:restaurent) { @user.restaurents.create(name: 'Test restaurent', place: 'Test Place', status: 'open') }

  describe 'PATCH #update' do

    it 'updates a restaurent' do
      patch :update, params: { id: restaurent.id, restaurent: { name: 'Updated restaurent', place: 'Updated Place', status: 'close' } }
      expect(response).to have_http_status(200)
    end

    it 'does not update a restaurent with invalid parameters' do
      patch :update, params: { id: restaurent.id, restaurent: { name: nil, place: 'Updated Place', status: 'close' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do

    it 'deletes a restaurent' do
      delete :destroy, params: { id: restaurent.id }
      expect(response).to have_http_status(200)
    end

    it 'generates Error message if not deleted' do
      delete :destroy, params: {id: restaurent.id-1}
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #search' do
    # let!(:restaurent) { restaurent.create(name: 'Test restaurent', place: 'Test Place', status: 'open') }

    it 'searches for a restaurent' do
      get :search, params: { name: 'Test' }
      expect(response).to be_successful
    end

    it 'returns an error message if no restaurent is found' do
      get :search, params: { name: 'Invalid' }
      expect(response).to have_http_status(404)
    end
  end

end
