Rails.application.routes.draw do
  authenticated :user, ->(user) { user.is_admin? } do
    root to: "admin/users#index", as: :admin_root
  end
  root to: 'pages#feeds'
  devise_for :users, :controllers => { :registrations => "users/registrations", sessions: 'users/sessions' }
    resources :users, shallow: true do
      resources :photos
      resources :albums
      member do
        get 'followings'
        get 'followers'
        get 'feeds_photos'
        get 'feeds_albums'
        get 'discover_photos'
        get 'discover_albums'
      end
    end
    resources :albums, shallow: true do
      resources :photos
    end

    namespace :admin do
      resources :users
      resources :photos, only: [:index]
      resources :albums, only: [:index]
    end

    post 'like/create/:photo_id', to: 'users#create_like', as: :create_like
    delete 'like/delete/:photo_id', to: 'users#delete_like', as: :delete_like

    post 'like/create_album/:album_id', to: 'users#create_like_album', as: :create_like_album
    delete 'like/delete_album/:album_id', to: 'users#delete_like_album', as: :delete_like_album

    post 'follow/create/:id', to: 'users#create_follow', as: :create_follow
    delete 'follow/delete/:id', to: 'users#delete_follow', as: :delete_follow

  post 'search/photo', to: 'search#index', as: 'search'
  get   'search/photo', to: 'search#index', as: 'search_photos'

  post 'search/album', to: 'search#search_album', as: 'search_album'
  get 'search/album', to: 'search#search_album', as: 'search_albums'

  post 'search/photo/suggestions', to: 'search#suggestions', as: 'search_suggestions'


  get 'feed', to: 'pages#feed'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
