Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  mount ActionCable.server => '/cable'
  devise_for :users, skip: [:passwords], :controllers => {
    :registrations => 'users/registrations',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  } 
  devise_scope :user do 
    # メールアドレスの設定画面をsettings/email.html.erbからdevise/registrations/edit.html.erbに移行
    get 'settings/email' => 'devise/registrations#edit', as: :email_settings
  end

  root to: 'welcome#index'
  resources :messages, only: %i(index create show)
  resources :matching, only: %i(index)

  resources :users, only: %i(index show)
  resources :mails, only: %i(index create)
  resources :relationships, only: %i(create)
  resources :contacts, only: %i(new create)
  resources :settings, only: %i(index create) do
    collection do
      get :mail_notification
      # メールアドレスの設定画面をsettings/email.html.erbからdevise/registrations/edit.html.erbに移行したためコメントアウト
      # get :email
      # Facebookログインのみの実装により、パスワードの変更は現状必要ないのでコメントアウトしておく
      # get :password
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

  get 'about' => 'about#index'
  namespace :about do
    get 'message_from_baree'
    get 'usage'
  end
end
