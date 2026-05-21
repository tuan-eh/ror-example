Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # 1. The Root Page is now the Projects list
  root "projects#index"

  # 2. Project CRUD + Nested Tasks
  resources :projects do
    # This creates URLs like: GET /projects/1/tasks
    resources :tasks, only: [ :index, :create ]
  end

  # 3. Global Task Actions (for editing, updating, or deleting a specific task)
  # We don't need the project ID in the URL to delete Task #5
  resources :tasks, only: [ :edit, :update, :destroy ]
end
