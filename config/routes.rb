Rails.application.routes.draw do
  resources :video_sources, only: %i[create]
  resources :videos, only: %i[index]
  resources :users, only: %i[new create]
  root 'videos#index'
  get '/share', to: 'video_sources#new'
  get '/register', to: 'users#new'
end