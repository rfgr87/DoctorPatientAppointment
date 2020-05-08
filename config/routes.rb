Rails.application.routes.draw do
  resources :complains
  root 'application#home'

  get '/doctors/login', to: 'doctors#login'
  post '/doctors/login', to: 'doctors#create_session'
  get '/doctors/logout', to: 'doctors#logout'
  get '/doctors/:id/patients', to: 'doctors#patients'
   
  get '/patients/login', to: 'patients#login'
  post '/patients/login', to: 'patients#create_session'
  get '/patients/logout', to: 'patients#logout'
  
  resources :doctors, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :patients, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :appointments, only: [:new, :create, :show, :edit, :update, :destroy]

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
