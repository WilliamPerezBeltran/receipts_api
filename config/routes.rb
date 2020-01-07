# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'refunds/create'
  # get 'consignations/create'
  resources :items
  resources :companies, only: %i[index create update destroy]
  resources :receipts, only: %i[index create update destroy]
  # get 'receipts/index'
  # resources :registrations, only:[:create,:delete, :update]
  post 'authenticate', to: 'authentication#authenticate'

  post '/signup' => 'registrations#create', defaults: { format: 'json' }
  delete '/delete_user' => 'registrations#delete', defaults: { format: 'json' }
  put '/update_user' => 'registrations#update', defaults: { format: 'json' }
  # get '/all_receipts' => 'receipts#index', defaults: { format: 'json' }
  get '/all_companies' => 'companies#index', defaults: { format: 'json' }
  post '/create_receipt' => 'receipts#create', defaults: { format: 'json' }
  get '/all_receipts' => 'receipts#index', defaults: { format: 'json' }
  post '/find_receipt_by_id' => 'receipts#find_by_id', defaults: { format: 'json' }
  post '/create_payment' => 'payments#create', defaults: { format: 'json' }
  post '/create_consignation' => 'consignations#create', defaults: { format: 'json' }
  post '/create_refund' => 'refunds#create', defaults: { format: 'json' }
  post '/get_consignation_to_show_receipt' => 'receipts#get_consignations', defaults: { format: 'json' }
  post '/get_payments_to_show_receipt' => 'payments#get_payments', defaults: { format: 'json' }
  post '/get_all_refunds' => 'refunds#get_refunds', defaults: { format: 'json' }
  # post '/update_company' => 'companies#updateCompany', defaults: { format: 'json' }
end
