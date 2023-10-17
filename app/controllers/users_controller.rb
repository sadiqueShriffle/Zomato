class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create 

  skip_before_action :customer_check
  skip_before_action :owner_check

  def show
    render json: @current_user, status:200
  end

  def create
    user = User.new(user_param)
    if user.save
      return render json: user, status:200
    end
    render json: user.errors.full_messages
  end

  def update
    if @current_user.update(user_param)
      render json: {message: 'User Updated Successfully'},status:200
    else
    render json: @current_user.errors.full_messages
    end
  end

  def destroy
    return render json: {message: 'User Deleted Successfully'} if @current_user.destroy
    render json: @current_user.errors.full_messages
  end

  private
  def user_param
    params.permit([:name,:email,:password,:type])
  end

end