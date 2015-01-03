Rails.application.routes.draw do
  #devise_for :users

  namespace :api do
    resources :availability_requests
    resources :locations, only: [:index]
  end

  resources :users, only: [] do
    member do
      get :deactivate
    end

    resources :availability_requests, only: [] do
      member do
        get :deactivate
        get :deactivate_found
      end
    end
  end
  #get '/*path', to: 'angular#index'
  root 'angular#index'

end
