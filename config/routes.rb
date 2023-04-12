Rails.application.routes.draw do
  root "video_sources#index"
  resources :video_sources, only: %i[index new create]
end