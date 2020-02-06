Rails.application.routes.draw do
  root to: 'top#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :top, only: [:new, :create]
  resources :users, only: :show do
    get 'logoutpage'
  end
  resources :items, only: [:index, :new, :create, :show]
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
