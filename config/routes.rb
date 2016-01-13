Rails.application.routes.draw do
  resources :comments
  get 'profile', to: "users#about"

  devise_for :users
  resources :recipes do
    resources :comments
  end

  root "recipes#index"
end
