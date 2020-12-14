Identity::Engine.routes.draw do
  namespace :v1 do
    resources :auth, only: [:create]
  end
end
