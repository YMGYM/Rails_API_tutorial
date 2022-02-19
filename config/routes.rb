Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :workouts, only: [:index, :create, :update, :destroy]
    post 'auth/test', to: 'auth#test', as: :auth_test
  end
end
