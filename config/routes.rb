Rails.application.routes.draw do
  root to: 'top#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :top, only: [:new, :create]
  resources :users, only: [:show, :edit, :update] do
    collection do
      get 'before_logout'
    end
  end
  resources :items, only: [:index, :new, :create, :show] do
    collection do
      get 'saling_show'
      get 'saled_show'
    end
    member do
      get 'before_buy'
      post 'buy'
    end


  end

  resources :cards, only: [:create, :show, :index, :new, :destroy] do
  end
  resources :addresses, only: [:new, :create, :edit, :update]

end