Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  mount ActionCable.server => '/cable'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  } 
  root to: 'welcome#index'
  resources :messages, only: %i(index create show)
  resources :matching, only: %i(index)

  resources :users, only: %i(index show)
  resources :relationships, only: %i(create)
  resources :contacts, only: %i(new create)
  resources :settings, only: %i(index create)

  namespace :likes do
    get 'sent'
    get 'received'
  end
end
