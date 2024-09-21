Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "sessions#new"
  get 'auth/:provider/callback', to: 'sessions#omniauth_callback'
  resource :users, only: %i[show]
end
