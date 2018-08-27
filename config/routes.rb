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
      get :insert_reply_form
      get :remove_reply_form
    end
  end

  root to: 'links#index'
end
