Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
end
