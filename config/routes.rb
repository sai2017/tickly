Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  get 'welcome' => 'welcome#index'
  resources :messages, only: %i(create show)
  resources :matching, only: %i(index)

  resources :users, only: %i(index show) do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create)
end
