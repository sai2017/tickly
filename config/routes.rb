Rails.application.routes.draw do
  devise_for :users
  get 'welcome' => 'welcome#index'

  resources :users, only: %i(index show)
end
