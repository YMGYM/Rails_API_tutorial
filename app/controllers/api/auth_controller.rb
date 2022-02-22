class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:test, :sign_up, :sign_in] # csrf 토큰 스킵
  # before_action :jwt_authenticate_request!, only[:test]

  # def test
  #   # 그냥 테스트 메소드
  #   @dataJson = { :message => "Token 인증 완료", :user => @current_user }
  #   render json: @dataJson, except: [:id, :created_at, :updated_at]
  # end

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: @user # TODO: AMS serialize
    else
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized # TODO: 에러 코드 맞는지 확인
    end
  end

  def sign_in
    json_params = JSON.parse(request.body.read)

    user = User.find_for_database_authentication(email: user_params[:email])
    if user.valid_password?(user_params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private
  def payload(user)
    # TODO : 그냥 30일 기준으로 판단하는 단순한 코드. Refresh Token 을 사용하지 않기 때문에 이를 사용하는 코드로 변경이 필요하다.
    @token = JWT.encode({ user_id: user.id, exp: 30.days.from_now.to_i}, ENV["SECRET_KEY_BASE"])
    @tree = { :"JWT token" => @token, :userInfo => { id: user.id, email: user.email } }
    return @tree
  end

  def user_params
    # TODO: parsing 과정에서 에러 발생 시 리턴값 지정
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read)) # read user info
    json_params.require(:auth).permit(:email, :password, :password_confirmation)
  end
end
