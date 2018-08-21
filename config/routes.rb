Rails.application.routes.draw do
  devise_for :users

  resources :links do
    member do
      put :upvote
      put :downvote
    end

    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy] do
    resources :comments, only: [:create, :destroy]

    member do
      put :upvote
      put :downvote
    end
  end

  root to: 'links#index'
end
