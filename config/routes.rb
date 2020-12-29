Rails.application.routes.draw do
  get 'pages/index'
  root to: 'pages#index'

  resources :cars
  resources :people
  resources :bookings

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
