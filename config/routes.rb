Rails.application.routes.draw do
  namespace :admin do
    resources :movies, only: [:index, :new, :create]
  end

  get 'movies', to: 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
