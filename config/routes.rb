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
  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
  resources :cards, only: [:index, :new, :create]
  resources :addresses, only: [:new, :create]
end