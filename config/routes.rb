Rails.application.routes.draw do
  require "sidekiq/web"
  get 'viewings/create'
  devise_for :users
  root to: 'pages#home'
  resources :series do
    resources :likes, only: [:create, :destroy]
  end
  resources :seasons do
    resources :likes, only: [:create ]
  end
  resources :episodes do
    resources :likes, only: [:create]
  end
  resources :likes, only: [:destroy]
  # get '/series/:id', to: 'series#show', as: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/whishlist', to: 'pages#whishlist'
  get '/library', to: 'pages#library'
  post '/viewed', to: 'series#viewed'
  #resources :viewings, only: [:create, :destroy]
  resources :viewings
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
