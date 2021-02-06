Rails.application.routes.draw do
  get 'viewings/create'
  devise_for :users
  root to: 'pages#home'
  resources :series do
    resources :likes, only: [:create ]
    resources :viewings, only: [:create]
  end
  # get '/series/:id', to: 'series#show', as: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/whishlist', to: 'pages#whishlist'
end
