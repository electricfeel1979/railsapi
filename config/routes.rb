Rails.application.routes.draw do
  # get '/articles', to: 'articles#index'
  # resources :articles, only: [:index]
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  resources :articles, only: %i[index show]
end
