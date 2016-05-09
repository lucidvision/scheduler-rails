Rails.application.routes.draw do
  devise_for :users
  resource :session, only: [:create, :destroy]
  resources :projects, only: [:index]
end
