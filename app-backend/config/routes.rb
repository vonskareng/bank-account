Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/ping", to: "ping#show", format: :json, as: :ping
  match "/transactions", to: "transactions#handle_transaction", via: [:all]
  get "/transactions/:transaction_id", to: "transactions#transaction_by_id", format: :json
  get "/accounts/:account_id", to: "accounts#account_id", format: :json
end
