Rails.application.routes.draw do
  resources :teams do
    resources :meetings
  end
  resources :documents
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'home#search'
end
