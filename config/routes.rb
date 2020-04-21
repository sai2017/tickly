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
  resources :settings, only: %i(index create) do
    collection do
      get :mail_notification
      get :email
      get :password
    end
  end

  namespace :likes do
    get 'sent'
    get 'received'
  end

  namespace :mypage do
    get 'my_profile'
    get 'edit'
    patch 'update'
    put 'update'
  end
end
