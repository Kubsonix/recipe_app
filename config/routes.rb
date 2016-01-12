Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :recipes do
    resources :comments    
  end

  root "recipes#index"
end
