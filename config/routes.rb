Rails.application.routes.draw do
  root 'users#index'
  get 'users/:id' => 'users#show', as: :user
  get 'posts/:id' => 'posts#show', as: :post
end
