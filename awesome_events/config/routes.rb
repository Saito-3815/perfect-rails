Rails.application.routes.draw do
  resources :events
  root "welcome#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resource :retirements

  resources :events do
    resources :tickets
  end

  get "status", to: "status#index", defaults: { format: "json" }
end
