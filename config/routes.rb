Rails.application.routes.draw do
  resources :bookmarks
  resources :users
  
  post '/login', to: 'users#login'
end
