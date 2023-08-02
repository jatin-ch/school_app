Rails.application.routes.draw do
  # Sidekiq web view
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  
  devise_for :users
  root to: 'home#index'

  resources :users do
    collection do
      delete :sign_out
      match :profile, via: [:get, :post]
      get 'profile/edit', to: 'users#edit_profile'
      match :enrollments, via: [:get, :post]
      get 'enrollments/new', to: 'users#new_enrollment'
      get 'enrollments/:enrollment_id', to: 'users#show_enrollments', as: :enrollment
    end
  end

  resources :schools do
    resources :courses do
      resources :batches do
        resources :enrollments
      end
    end
  end
end
