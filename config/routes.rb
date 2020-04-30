Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :travellists
      get :followings
      get :followers
      get :likes
    end
    collection do
      get :search
    end
  end
  
  resources :desks
  resources :travels do
    collection do
      get :search
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :travel_comments, only: [:create]
end