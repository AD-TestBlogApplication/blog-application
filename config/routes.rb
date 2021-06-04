# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :users

  resources :posts do
    resources :comments, only: %i[create], module: :posts
  end

  resources :comments, only: %i[edit update destroy]
end
