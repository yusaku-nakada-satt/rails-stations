Rails.application.routes.draw do
  get 'sheets/index'
  namespace :admin do
    resources :movies, only: [:index, :show,:new, :create, :update, :edit, :destroy] do
      resources :schedules, only: [:new, :create, :update, :edit]
    end
    resources :schedules, only: [:index, :show, :destroy]
  end

  resources :movies, only: [:index, :show, :reservation] do
    get :reservation
    resources :schedules do
      resources :reservations, only: [:new]
    end
  end
  resources :sheets, only: [:index]
  resources :reservations, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
