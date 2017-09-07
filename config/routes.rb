require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :users, only: [:new, :create, :show]
  namespace :api do
    resource :charts, only: [] do
      get :games_summary
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#new'
end
