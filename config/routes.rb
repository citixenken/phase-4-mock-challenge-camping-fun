Rails.application.routes.draw do
  resources :campers, only: [:index, :show, :create]
  resources :signups
  resources :activities, only: [:index, :destroy]
end
