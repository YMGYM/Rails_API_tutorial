class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:sign_up, :sign_in] # csrf 토큰 스킵
  # before_action :jwt_authenticate_request!, only[:test]

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
    json_params = JSON.parse(request.body.read)

    @user = User.find_for_database_authentication(email: user_params[:email])
    if @user.valid_password?(user_params[:password])
      render json: payload(@user), status: :ok
    else
      render json: { errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private
  def payload(user)
    # TODO : 그냥 30일 기준으로 판단하는 단순한 코드. Refresh Token 을 사용하지 않기 때문에 이를 사용하는 코드로 변경이 필요하다.
    # TODO : 왜 @token 클래스 변수?
    @token = JWT.encode({ user_id: @user.id, exp: 30.days.from_now.to_i}, ENV["SECRET_KEY_BASE"])
    @tree = { autorization: @token, userInfo: UserSerializer.new(@user) }
    return @tree
  end

  def user_params
    # TODO: parsing 과정에서 에러 발생 시 리턴값 지정
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read)) # read user info
    json_params.require(:auth).permit(:email, :password, :password_confirmation)
  end
end
