Rails.application.routes.draw do
  resources :comments
  get 'profile', to: "users#about"
  get 'my_recipes', to: "users#my_recipes"

  devise_for :users
  resources :recipes do
    collection do
      get 'search'
    end
    resources :comments
  end

  root "recipes#index"
end
