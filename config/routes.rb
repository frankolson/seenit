Rails.application.routes.draw do
  devise_for :users

  resources :links do
    member do
      put :upvote
      put :downvote
    end
    resources :comments, only: [:create, :destroy]
  end

  root to: 'links#index'
end
