# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :users, only: [] do
      collection do
        post :sign_up, to: 'users#create'
        post :sign_in, to: 'users#authenticate'
      end

      resources :posts, only: %i[index], module: :users
    end

    resources :posts, only: %i[index create show update destroy] do
      scope module: :posts do
        resources :comments, only: %i[create]
        resources :emote_reactions, only: %i[create]
      end
    end

    resources :comments, only: %i[update destroy] do
      resources :emote_reactions, only: %i[create], module: :comments
    end
  end

  devise_for :users

  resources :users, only: [] do
    resources :posts, only: %i[index], module: :users
  end

  resources :posts do
    scope module: :posts do
      resources :comments, only: %i[create]
      resources :emote_reactions, only: %i[create]
    end
  end

  resources :comments, only: %i[edit update destroy] do
    resources :emote_reactions, only: %i[create], module: :comments
  end
end
