Rails.application.routes.draw do
  resources :complains
  root 'application#home'

  get '/auth/facebook/callback' => 'patients#facebook_create'
  match '/auth/:provider/callback', to: 'patients#facebook_create', via: [:get, :post]

  get '/doctors/login', to: 'doctors#login'
  post '/doctors/login', to: 'doctors#create_session'
  get '/doctors/logout', to: 'doctors#logout'
  get '/doctors/failure', to: 'doctors#failure'

  get 'appointments/search', to: 'appointments#search'
  post 'appointments/search', to: 'appointments#search_results'
   
  get '/patients/login', to: 'patients#login'
  post '/patients/login', to: 'patients#create_session'
  get '/patients/logout', to: 'patients#logout'
  get '/patients/failure', to: 'patients#failure'

  get '/appointments/:id/prescription', to: 'appointments#prescription'
  post '/appointments/:id/prescription', to: 'appointments#create_prescription'
  
  resources :doctors, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :patients, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :appointments, only: [:new, :create, :show, :edit, :update, :destroy]

  # resources :appointments
  # resources :patients
  # resources :doctors

  resources :doctors, only: [:show] do
    resources :appointments, only: [:new, :show, :index]
  end

  resources :doctors, only: [:show] do
    resources :patients, only: [:index, :show]
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
