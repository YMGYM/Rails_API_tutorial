class ApplicationController < ActionController::Base
  attr_reader :current_user

  def jwt_authenticate_request!
    # user_id 정보가 없는지 확인 / 없을 시 error response 반환
    
  end
end
