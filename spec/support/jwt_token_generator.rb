module JwtTokenHelper
  require 'jwt'
  def generate_jwt_token(user_id)
    secret_key = Rails.application.secrets.secret_key_base.to_s
    payload = { user_id: user_id }
    JWT.encode(payload, secret_key, 'HS256')
  end
end