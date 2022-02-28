class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:sign_up, :sign_in] # csrf 토큰 스킵
  
  def sign_up
    @user = User.new(user_params)

    if @user.valid? # validation check (email 중복 체크)
      if @user.save
        render json: payload(@user), status: :ok
      else
        render json: { errors: ['Can not create user'] }, status: :conflict
      end
    else
      render json: { errors: ['Email has already been taken'] }, status: :conflict
    end
  end

  def sign_in
    @user = User.find_for_database_authentication(email: user_params[:email])
    if @user.valid_password?(user_params[:password])
      render json: payload(@user), status: :ok
    else
      render json: { errors: ['Invalid Username/Password']}, status: :unauthorized
    end

  rescue JSON::ParserError, NoMethodError
    render json: { errors: ['Bad Request'] }, status: :bad_request
  end

  private
  def payload(user)
    # TODO : 그냥 30일 기준으로 판단하는 단순한 코드. Refresh Token 을 사용하지 않기 때문에 이를 사용하는 코드로 변경이 필요하다.
    # TODO : 왜 @token 클래스 변수?
    @token = JWT.encode({ user_id: @user.id, exp: 30.days.from_now.to_i}, Rails.application.credentials.secret_key_base)
    @tree = { :"Authorization" => @token, :userInfo => UserSerializer.new(@user) }
    return @tree
  end

  def user_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read)) # read user info
    json_params.require(:auth).permit(:email, :password, :password_confirmation)

  rescue JSON::ParserError
    render json: { errors: ['Bad Request'] }, status: :bad_request
  end
end
