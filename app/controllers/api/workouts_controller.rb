class Api::WorkoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:index, :create, :show, :update, :destroy]
  before_action :jwt_authenticate_request!, only: [:index, :create, :show, :update, :destroy]
  before_action :set_workout, only: [:show, :update, :destroy]

  def index
    @workouts = Workout.all
    render json: @workouts, status: :ok
  end

  def create
    @workout = Workout.new(workout_params)

    if @workout.save
      render json: @workout
    else
      render json: { errors: ['Bad request']}, status: :bad_request
    end
  end

  def show
    render json: @workout
  end

  def update
    if @workout.update(workout_params)
      render json: @workout, status: :ok
    else
      render json: { errors: ['Bad request']}, status: :bad_request
    end
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

  def set_workout
    @workout = Workout.find(params[:id]) # TODO: 레코드를 찾을 수 없을 때 400 에러 핸들링
  # rescue RecordNotFound
  #   render json: { errors: ['Bad Request'] }, status: :bad_request
  end
end
