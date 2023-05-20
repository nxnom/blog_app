Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy]
  end

  resources :posts, only: [] do
    resources :comments, only: %i[index create destroy]
    resources :likes, only: %i[create]
  end

  # Defines the root path route ("/")
  root to: 'users#index'
end
