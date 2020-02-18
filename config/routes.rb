Rails.application.routes.draw do
  devise_for :users
  get 'welcome' => 'welcome#index'
end
