Rails.application.routes.draw do
  root "welcome#index"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resource :retirements, only: %i[new create]

  resources :events, only: %i[new create show edit update destroy] do
    resources :tickets, only: %i[new create destroy]
  end

  get "status", to: "status#index", defaults: { format: "json" }

  # どのルーティングにも当てはまらないリクエストの場合はerror404アクションを実行する
  match "*path" => "application#error404", via: :all
end
