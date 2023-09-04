class ApplicationController < ActionController::API
  include JwtToken
  before_action :authenticate_user
  before_action :owner_check
  before_action :customer_check

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  private 
  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header  
    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: "User not found" }, status: :unauthorized
    rescue JWT::DecodeError => e  
      render json: { error: "Login First" }, status: :unauthorized 
    end
    
  end

  def owner_check
    unless @current_user.owner?
        render json: {error: 'Owner not found..'}
    end
  end

  def customer_check
    unless @current_user.customer?
        render json: {error: 'Customer not found..'}
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  rescue_from NoMethodError, with: :handle_pram_exception
  
  def handle_exception
    render json: { error: 'Invalid Id ' }, status:404
  end

  def handle_pram_exception
    render json: {error: 'Param is missing or Empty Value'}, status:406
  end

end
