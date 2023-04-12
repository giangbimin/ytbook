Rails.application.routes.draw do
  root "video_sources#index"
  get "/share", to: "video_sources#new"
  resources :video_sources, only: %i[index create]
end