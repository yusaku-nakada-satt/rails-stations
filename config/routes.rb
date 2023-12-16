Rails.application.routes.draw do
  get 'sheets/index'
  namespace :admin do
    resources :movies, only: [:index, :new, :create, :update, :edit, :destroy]
  end

  resources :movies, only: [:index, :show]
  resources :sheets, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
