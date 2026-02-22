Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :users
  root 'static_pages#top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Devise admin root
  namespace :admin do
    root "dashboard#index"
    resources :restaurants, only: [:index, :show, :destroy]
    resources :search_restaurants, only: [:index, :create] do
      collection do
        get :search
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :restaurants, only: [:index, :show]
end
