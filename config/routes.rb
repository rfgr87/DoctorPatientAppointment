Rails.application.routes.draw do
  root 'application#home'
  get '/doctors/login', to: 'doctors#login'
  get '/patients/login', to: 'patients#login'
  
  resources :doctors, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :patients, only: [:new, :create, :show, :edit, :update, :destroy]

  get '/doctors/login', to: 'doctors#login'
  post '/doctors/login', to: 'doctors#login'
   
  get '/doctors/login', to: 'doctors#login'
  post '/doctors/login', to: 'doctors#login'

  # resources :appointments
  # resources :patients
  # resources :doctors

  resources :doctors, only: [:show] do
    resources :appointments, only: [:show, :index]
  end

  resources :patients, only: [:show] do
    resources :appointments, only: [:show, :index]
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
