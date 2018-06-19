Rails.application.routes.draw do
  resources :subs do
    resources :posts
  end
  resources :users, only: [:new, :create]
  
  resource :session
end
