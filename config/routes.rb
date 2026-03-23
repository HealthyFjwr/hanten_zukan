Rails.application.routes.draw do

  # letter opener webのルーティング設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # 本番用
  devise_for :admin_users, path: "admin"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "static_pages#top"

  namespace :admin do
    root "dashboard#index"
    resources :restaurants, only: %i[index show destroy]
    resources :search_restaurants, only: %i[index create] do
      collection do
        get :search
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :restaurants do
    resources :comments, only: %i[create update destroy]
    resource :bookmark, only: %i[create destroy]
  end

  scope :user do
    resources :bookmarks, only: %i[index]
    # get "profile", to: "users#show"
  end

  devise_scope :user do
    get "password/edit", to: "users/registrations#edit_password", as: :edit_password_setting
    patch "password", to: "users/registrations#update_password", as: :update_password_setting
  end
end
