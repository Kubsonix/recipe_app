Rails.application.routes.draw do
  resources :comments
  get 'profile', to: "users#about"

  devise_for :users
  resources :recipes do
    collection do
      get 'search'
    end      
    resources :comments
  end

  root "recipes#index"
end
