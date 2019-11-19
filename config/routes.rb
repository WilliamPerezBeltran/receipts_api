# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items
  # resources :registrations, only:[:create,:delete, :update]
  post 'authenticate', to: 'authentication#authenticate'

  post '/signup' => 'registrations#create', defaults: { format: 'json' }
  delete '/delete_user' => 'registrations#delete', defaults: { format: 'json' }
  put '/update_user' => 'registrations#update', defaults: { format: 'json' }
end
