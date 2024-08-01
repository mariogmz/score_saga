# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  namespace :api do
    devise_for :users, path: "", controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }, path_names: {
      sign_in: "session",
      registration: "user",
      sign_out: "logout"
    }
  end
end
