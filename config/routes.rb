Rails.application.routes.draw do
  root to: "home#index"

  get 'refresh/create'
  get 'signin/create'

  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy

  namespace :api do
    namespace :v1 do
      resources :messages
      resources :rooms
      resources :users
    end
  end
end
