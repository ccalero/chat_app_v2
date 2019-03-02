Rails.application.routes.draw do

  # Auth
  post 'auth/login', controller: :auth, action: :login
  post 'auth/signup', controller: :auth, action: :signup

  namespace :api do
    namespace :v1 do
      # Rooms
      get 'rooms', controller: :rooms, action: :index
      get 'rooms/:id', controller: :rooms, action: :show
      post 'rooms', controller: :rooms, action: :create

      # Users
      post 'users', controller: :users, action: :create

      # ActionCable
      mount ActionCable.server => '/cable'
    end
  end

end
