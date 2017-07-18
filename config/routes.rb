Rails.application.routes.draw do
  root 'welcome#index'

  get '/search', to: 'search#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :trips, only: [:new, :index, :create, :show]
    namespace :vendor do
      get '/dashboard', to: 'dashboard#index'
      resources :tours, only: [:new, :show, :index]
      post '/tours/:id', to: 'tours#create'
    end
  end

  namespace :users, path: ":id" do
    patch '/trips/change_password/update', to: 'passwords#update', as: :password_patch
    get '/trips/change_password/edit', to: 'passwords#edit', as: :password_edit
    get '/trips/change_password', to: 'passwords#reset', as: :password_reset

  end

  resources :confirmations, only: [:new, :create]

end
