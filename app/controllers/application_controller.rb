class ApplicationController < ActionController::Base
  attr_reader :current_user

  protected
  # jwt token authentication
  def jwt_authenticate_request!
    unless user_id_in_token? # no token in user_id
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end

    @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def http_token
    http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    # lib/json_web_token.rb
    auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    debugger
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
