Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  #Adding API endpoints for posts and comments
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resource :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
