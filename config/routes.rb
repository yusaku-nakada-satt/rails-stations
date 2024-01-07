Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/new', to: 'devise/registrations#new', as: :new_user_registration
    post 'users', to: 'devise/registrations#create', as: :user_registration
  end

  get 'sheets/index'
  namespace :admin do
    resources :movies, only: %i[index show new create update edit destroy] do
      resources :schedules, only: %i[new create update edit]
    end
    resources :schedules, only: %i[index show destroy]
    resources :reservations, only: %i[index new create show update destroy]
  end

  resources :movies, only: %i[index show reservation] do
    get :reservation
    resources :schedules do
      resources :reservations, only: [:new]
    end
  end
  resources :sheets, only: [:index]
  resources :reservations, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
