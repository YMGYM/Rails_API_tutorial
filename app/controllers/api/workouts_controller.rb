class WorkoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :jwt_authenticate_request!, only[:create, :update, :destroy]

  def create

  end

  def update
  end

  def destroy
  end

  private
  def workout_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read)) # read user info
    json_params.require(:workout).permit(:user_id, :exercise_id, :work_time, :calorie_amount)

  rescue JSON::ParserError
    render json: { errors: ['Bad Request'] }, status: :bad_request
  end
end
