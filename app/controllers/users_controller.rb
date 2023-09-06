class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create 

  skip_before_action :customer_check
  skip_before_action :owner_check

  def show
  render json: @current_user
  end

  def create
    @user = User.new(user_param)
    if @user.save
    UserMailer.with(user: @user).user_email.deliver_now
    return render json: @user
    end
    render json: @user.errors.full_messages
  end

  def update
    return render json: {message: 'User Updated Successfully'} if @current_user.update(user_param)
    render json: {errors: @current_user.errors.full_messages}
  end

  def destroy
    return render json: {message: 'User Deleted Successfully'} if @current_user.destroy
    render json: {errors: @current_user.errors.full_messages}
  end

  private
  def user_param
  params.permit([:name,:email,:password,:type,:image])
  end

end