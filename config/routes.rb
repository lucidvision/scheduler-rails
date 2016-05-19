Rails.application.routes.draw do
  devise_for :users
  resource :session, only: [:create, :destroy]
  resources :projects, only: [:index] do
    get 'reset_data', on: :collection
  end
  resources :auditions, only: [:index, :update] do
    put 'update_status', on: :collection

    resources :histories, only: [:index, :create]
  end
end
