Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 
    devise_for :users
    root "posts#index"
    resources :posts do 
      resources :comments
      resources :likes
      resources :dislikes
    end
    resources :places
    get "/user_profile/:id", to: "user_profile#index", as: :profile
    get "/user_info/:id", to: "user_info#index", as: :info

    post "posts/:post_id/create_like", to: "likes#create", as: :create_like
    delete "posts/:post_id/likes/:id", to: "likes#destroy", as: :delete_like
    post "posts/:post_id/create_dislike", to: "dislikes#create", as: :create_dislike
    delete "posts/:post_id/dislikes/:id", to: "dislikes#destroy", as: :delete_dislike

    get "user_profile/:id/add_phone_number", to: "phone_numbers#new", as: :add_phone_number
    post "/profile/user_info/:id", to: "phone_numbers#create", as: :create_phone_number
    
    authenticated :user, -> (user) {user.has_role? :admin} do 
      get 'admin', to: "admin#index"
      get 'admin/posts'
      get 'admin/comments'
      get 'admin/users'
      get 'admin/show_post/:id', to: "admin#show_post", as: :admin_post
    end


    devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy' 
    end

    resources :places

  end
end