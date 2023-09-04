class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create 

  skip_before_action :customer_check
  skip_before_action :owner_check

  def show
  render json: @current_user
  end

  def create
    @sign_up = User.new(user_param)
    if @sign_up.save
    UserMailer.user_email(@sign_up).deliver_now!
    return render json: @sign_up
    end
    render json: @sign_up.errors.full_messages
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