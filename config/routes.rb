Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  root to: 'welcome#index'
  resources :messages, only: %i(index create show)
  resources :matching, only: %i(index)

  resources :users, only: %i(index show)
  resources :relationships, only: %i(create)

  namespace :likes do
    get 'sent'
    get 'received'
  end
end
