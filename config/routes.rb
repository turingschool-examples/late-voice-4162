Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/customers/:id", to: "customers#show", as: :customer

  post "/customer_items", to: "customer_items#create", as: :create_customer_item

  get "/items", to: "items#index"
end
