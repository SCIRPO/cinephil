Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :series do
    resources :likes, only: [:create ]
  end
  # get '/series/:id', to: 'series#show', as: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
