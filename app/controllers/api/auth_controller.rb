class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:test]
  before_action :jwt_authenticate_request!, only[:test]

  def test
    @dataJson = { :message => "Token 인증 완료", :user => @current_user }
    render json: @dataJson, except: [:id, :created_at, :updated_at]
  end
end
