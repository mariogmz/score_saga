# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  scope :api do
    devise_for :users, path: "", path_names: {
    sign_in: "sessions",
    sign_out: "sessions",
    registration: "user"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    },
    defaults: { format: :json }
  end

  namespace :api, defaults: { format: :json } do
    scope :user do
      resources :game_events, only: %i[index create]
    end
  end
end
