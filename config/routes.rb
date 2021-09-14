Rails.application.routes.draw do
  match "/500", to: "http_errors#internal_server_error", via: :all

  resource :session, only: %i[new create]
  resources :messages, only: %i[index show update] do
    get :latest, on: :collection
  end
end
