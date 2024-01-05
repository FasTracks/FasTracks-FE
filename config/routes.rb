Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  get "/callback", to: "callback#callback"

  get "/generate_playlist", to: "playlist#generate"
  post "/playlist", to: "playlist#create"
  get "/playlist", to: "playlist#show"
end
