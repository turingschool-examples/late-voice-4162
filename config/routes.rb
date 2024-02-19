Rails.application.routes.draw do
  get "/customers/:id", to: "customers#show"

  post "/customers/:customer_id", to: "customers#show"
end
