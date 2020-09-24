Rails.application.routes.draw do
  resources :teams do
    resources :meetings
  end
  resources :documents
  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
