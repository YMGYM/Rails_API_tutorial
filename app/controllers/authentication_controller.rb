class AuthenticationController < ApplicationController
  def authenticate_user
    json_params = JSON.parse(request.body.read)

    user = User.find_for_database_authentication(email: json_params[:auth][:email])
    if user.valid_password?(json_params[:auth][:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password']}, status: :unautorized
    end
  end

  private
  def payload(user)
    @token = JWT.encode({ user_id: user.id, exp: 30.days.from_now.to_i}, ENV["SECRET_KEY_BASE"])
    @tree = { :"JWT token" => @token, :userInfo => { id: user.id, email: user.email } }

    return @tree
  end
end