Rails.application.routes.draw do
  devise_for :users

  #get '/*path', to: 'angular#index'
  root 'angular#index'

end
