Rails.application.routes.draw do
  devise_for :users

  resources :links do
    resources :comments, only: [:create, :destroy]
  end

  root to: 'links#index'
end
