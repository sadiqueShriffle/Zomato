class AuthenticationController < ApplicationController
  include JwtToken
  skip_before_action :authenticate_user
  skip_before_action :owner_check
  skip_before_action :customer_check

  def login 
    @user = User.find_by(email: params[:email])
    
    return  render json: {error: "User Not exist Resgister first"}, status: :unauthorized unless @user

    if @user.authenticate(params[:password])
      token = jwt_encode({user_id: @user.id})
      render json: {message: 'Login Successfully', token:token}, status: :ok 
    else
      render json: { error: 'Incorrect Password' }, status: :unauthorized
    end
  end
end
