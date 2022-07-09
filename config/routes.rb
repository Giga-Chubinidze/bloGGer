Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 
    devise_for :users
    root "posts#index"
    resources :posts do 
      resources :comments
      resources :likes
      resources :dislikes
    end
    get "/profile/:id", to: "user_profile#index", as: :profile
    
    devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy' 
    end

  

  end
end