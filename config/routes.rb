Rails.application.routes.draw do
  resources :comments
  resources :commented_quakes
  resources :bookmarks
  resources :users
  
  post '/login', to: 'users#login'
end
