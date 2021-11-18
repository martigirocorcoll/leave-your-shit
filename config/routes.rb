Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :locations do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:show, :update]
  resource :dashboard, only: [:show]
end
