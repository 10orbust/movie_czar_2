Rails.application.routes.draw do
  root to: "events#index"

  resources :events 
  resources :invites, only: [:index, :update, :destroy, :new, :create, :edit]
  resources :groups, only: [:show, :update, :destroy, :new, :create, :edit]
  resources :rsvps, only: [:index, :update, :destroy, :new, :create, :edit]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
