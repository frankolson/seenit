Rails.application.routes.draw do
  devise_for :users

  resources :links do
    resources :comments
  end

  root to: 'links#index'
end
