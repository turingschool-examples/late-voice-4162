Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/customer/:id", to: "customer#show"
  # Defines the root path route ("/")
  # root "articles#index"
end
