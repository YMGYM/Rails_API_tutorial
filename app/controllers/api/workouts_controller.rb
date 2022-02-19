class WorkoutsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :jwt_authenticate_request!, only[:create, :update, :destroy]

  def create
  end

  def update
  end

  def destroy
  end
end
