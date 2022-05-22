# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  devise_for :accounts

  resources :accounts do
    member do
      match 'add_nominee', via: %i[get post]
    end
    collection do
      get 'edit_nominee'
      delete 'remove_nominee'
      patch 'update_nominee'
    end
  end
  delete 'logout', to: 'sessions#destroy'
end
