Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations", sessions: 'users/sessions' }
  resources :users, shallow: true do
    resources :photos
    resources :albums
    member do
      get 'followings'
      get 'followers'
    end
  end
  resources :albums, shallow: true do
    resources :photos
  end





  get 'followings', to:'follows#followings'
  get 'feed', to: 'pages#feed'
  get 'followings', to:'pages#followings'
  root 'pages#feed'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
