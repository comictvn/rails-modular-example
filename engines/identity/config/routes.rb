Identity::Engine.routes.draw do
  namespace :v1 do
    resources :auth, only: [:create]
    resources :logout, only: [:create]
    resources :me, only: [:index]
    resources :followers, only: [:create, :destroy]
  end
end
