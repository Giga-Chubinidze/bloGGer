Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 
    devise_for :users
    root "posts#index"
    resources :posts do 
      resources :comments
      resources :likes
      resources :dislikes
    end
    get "/profile/user_profile/:id", to: "user_profile#index", as: :profile
    get "/profile/user_info/:id", to: "user_info#index", as: :info

    post "posts/:post_id/create_like", to: "likes#create", as: :create_like
    delete "posts/:post_id/likes/:id", to: "likes#destroy", as: :delete_like
    post "posts/:post_id/create_dislike", to: "likes#create", as: :create_dislike
    delete "posts/:post_id/dislikes/:id", to: "dislikes#destroy", as: :delete_dislike

    devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy' 
    end

  

  end
end