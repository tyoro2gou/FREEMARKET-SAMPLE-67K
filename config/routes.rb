Rails.application.routes.draw do
  root to: 'top#index'
  devise_for :users
  resources :top, only: [:new, :create]
  resources :users, only: :show do
    get 'logoutpage'
  end
  resources :items, only: [:index, :new, :create, :show]
  resources :cards, only: [:index, :new, :create]
end
