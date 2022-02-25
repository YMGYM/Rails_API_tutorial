Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :workouts, only: [:index, :create, :update, :destroy]
    resources :auth, only: [] do
      collection do
        post :sign_up
        post :sign_in
      end
    end
    post 'auth/test', to: 'auth#test', as: :auth_test
  end
end
