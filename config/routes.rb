# frozen_string_literal: true
Rails.application.routes.draw do

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :sessions, only: [:create, :destroy] do
        collection do
          get :current
          post :restore_password
          put :reset_password
        end
      end
      resources :attachments, only: [:create]
      resources :appointments
      resources :devices, only: [:create]
      resources :users do
        member do
          get :statistics
        end
        put :change_password, on: :collection

        resources :directions do
          resources :steps
        end

        resources :notification_settings, only: :update
      end
      resources :authorizations, only: [:index, :destroy]
    end
  end
end
