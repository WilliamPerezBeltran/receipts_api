# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items
  resources :companies, only: %i[index create update destroy]
  # get 'receipts/index'
  # resources :registrations, only:[:create,:delete, :update]
  post 'authenticate', to: 'authentication#authenticate'

  post '/signup' => 'registrations#create', defaults: { format: 'json' }
  delete '/delete_user' => 'registrations#delete', defaults: { format: 'json' }
  put '/update_user' => 'registrations#update', defaults: { format: 'json' }
  get '/all_receipts' => 'receipts#index', defaults: { format: 'json' }
  post '/create_receipt' => 'receipts#create', defaults: { format: 'json' }
  # post '/update_company' => 'companies#updateCompany', defaults: { format: 'json' }
end
