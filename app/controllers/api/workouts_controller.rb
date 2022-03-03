class Api::WorkoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:index, :create, :show, :update, :destroy]
  before_action :jwt_authenticate_request!, only: [:index, :create, :show, :update, :destroy]
  before_action :set_workout, only: [:show, :update, :destroy]

  def index
    @workouts = current_user.workouts
    render json: @workouts, status: :ok
  end

  def create
    @workout = current_user.workouts.new(workout_params)

    if @workout.save
      render json: @workout
    else
      render json: { errors: ['Cannot save entity']}, status: :unprocessable_entity
    end
  end

  def show
    render json: @workout
  end

  def update
    if @workout.update(workout_params)
      render json: @workout, status: :ok
    else
      render json: { errors: ['Cannot update entity']}, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    head :no_content # convention of scaffold.. TODO: 이게 맞..나? 프론트 입장에서 이게 이해가 되나?
  end

  private
  def workout_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read)) # read user info
    json_params.require(:workout).permit(:exercise_id, :work_time, :calorie_amount)
  rescue JSON::ParserError
    render json: { errors: ['Bad Request'] }, status: :bad_request
  end

  def set_workout
    @workout = Workout.find(params[:id])
    if @workout.user != current_user # is record made by current_user?
      render json: { errors: ["You don't have permission for this entity"] }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Record Not Found'] }, status: :unprocessable_entity
  end
end
