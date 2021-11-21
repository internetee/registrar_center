Rails.application.routes.draw do
  match "/500", to: "http_errors#internal_server_error", via: :all

  resource :session, only: %i[new create]
  resources :messages, only: %i[index show update] do
    get :latest, on: :collection
  end
  resource :balance_check, only: %i[show]

  resources :contacts, only: %i[index show edit update destroy new create] do
    get :check, on: :collection
  end

  resources :domains, only: %i[index show edit update destroy new create], param: :domain_name do
    put :renew, on: :collection
    put :add_hold, on: :collection
    delete :remove_hold, on: :collection
    get :transfer_info, on: :member
    post :transfer, on: :member

    collection do
      post 'transfer', to: 'bulk_actions#domain_transfer'
      patch 'contacts', to: 'bulk_actions#contact_replace'
      post 'renew', to: 'bulk_actions#domain_renew'
      put 'nameserver', to: 'bulk_actions#nameserver_change'
    end
  end

  resources :nameservers, only: %i[show new create destroy], param: :domain_name
  resources :dnssecs, only: %i[show new create destroy], param: :domain_name
end
