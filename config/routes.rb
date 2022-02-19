Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    recources :workouts, only: [:index, :create, :update, :destroy]
  end
end
