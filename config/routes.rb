RottenMangoes::Application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create, :edit, :update]
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'

  namespace :admin do
    resources :users do
      member do
        get 'possess'
      end
    end
  end

  get '/search', to: 'search#run'

end