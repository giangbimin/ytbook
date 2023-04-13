Rails.application.routes.draw do
  resources :video_sources, only: %i[create]
  resources :videos, only: %i[index]
  root 'videos#index'
  get '/share', to: 'video_sources#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end