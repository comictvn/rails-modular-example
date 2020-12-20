ClockOperation::Engine.routes.draw do
  namespace :v1 do
    resources :sleeping_records, only: [:index, :create, :update]
    resources :friend_sleepings, only: [:index, :create, :update]
  end
end
