Rails.application.routes.draw do
  root to: 'top#index'
  devise_for :users
  resources :top, only: [:new, :create]
  resources :users, only: :show do
    collection do
      get 'before_logout'
    end
  end
  resources :items, only: [:index, :new, :create, :show] do
    collection do
      get 'saling_show'
      get 'saled_show'
    end
  end
  resources :cards, only: [:create, :show, :index, :new] 
  resources :addresses, only: [:new, :create]
end