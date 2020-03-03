Rails.application.routes.draw do
  devise_for :users
  get 'welcome' => 'welcome#index'

  resources :users, only: %i(index show) do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create)
end
