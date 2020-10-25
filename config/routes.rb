Rails.application.routes.draw do
  resources :teams do
    resources :meetings, except: [:index]
  end
  resources :documents, except: [:index]
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'home#search'
  get 'user_index', to: 'home#user_index'
  get 'toggle_status', to: 'home#toggle_status'
  get 'toggle_admin', to: 'home#toggle_admin'
  delete 'destroy_user', to: 'home#destroy_user'
  get 'send_meeting', to: 'meetings#send_meeting'
  get 'join_team', to: 'teams#join_team'
  get 'profile', to: 'home#profile'
end
