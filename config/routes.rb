Rails.application.routes.draw do
  resources :places
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 
    devise_for :users
    root "posts#index"
    resources :posts do 
      resources :comments
      resources :likes
      resources :dislikes
    end
    resources :users
    resources :places
    get "/user_profile/:id", to: "user_profile#index", as: :profile
    get "/user_info/:id", to: "user_info#index", as: :info

    post "posts/:post_id/create_like", to: "likes#create", as: :create_like
    delete "posts/:post_id/likes/:id", to: "likes#destroy", as: :delete_like
    post "posts/:post_id/create_dislike", to: "dislikes#create", as: :create_dislike
    delete "posts/:post_id/dislikes/:id", to: "dislikes#destroy", as: :delete_dislike

    get "user_profile/:id/add_phone_number", to: "phone_numbers#new", as: :add_phone_number
    post "/profile/user_info/:id", to: "phone_numbers#create", as: :create_phone_number
    devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy' 
    end

  

  end
end