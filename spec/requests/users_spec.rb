require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users" do
  let(:user) { create(:user, password: "password", password_confirmation: "password") }
  let (:token_new) { Users::CreateTokenService.call(user)}
  let(:token) do {  "Authorization": "Bearer #{token_new}"  }
  end
end
  describe "GET /user#show" do
    context "correct params are passed" do
      subject { get user_path( format: :json, params: {}, headers: token  )  }

      it "returns correct status" do
        subject
        expect(response).to have_http_status(200)
      end
    end
  end

end
