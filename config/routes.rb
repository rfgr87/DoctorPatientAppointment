Rails.application.routes.draw do
  resources :appointments
  resources :patients
  resources :doctors

  resources :doctors, only: [:show] do
    resources :appointments, only: [:show, :index]
  end

  resources :patients, only: [:show] do
    resources :appointments, only: [:show, :index]
  end

  root 'homepage#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
