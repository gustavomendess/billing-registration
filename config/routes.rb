Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :banks, only: %i[ create ]
      resources :companies, only: %i[ create index ], format: "json"
      resources :cost_centers, only: %i[ create ], format: "json"
    end
  end

  namespace :api do
    namespace :v1 do
      resources :participants, format: "json"
    end
  end
  
end
