class Api::ExercisesController < ApplicationController
  before_action :jwt_authenticate_request!, only: [:index, :show]
  before_action :set_exercise, only: [:show]

  def index
    @exercises = Exercises.all # TODO: filter 기능?
    render json: @exercises, status: :ok
  end

  def show
  end

  private
  def set_exercise
    @exercise = Exercise.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ['Record Not Found'] }, status: :unprocessable_entity
  end
end
