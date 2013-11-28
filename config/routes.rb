SampleApp::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :operations,    only: [:create, :destroy]
  resources :shipping_companies,  only: [:new, :create, :show, :index, :destroy] do
    get '/new-employee', :to => 'users#new_sce', :as => :new_sce
    post '/new-employee', :to => 'users#create_sce', :as => :create_sce
    resources :fleets,    only: [:show, :edit, :update, :index, :new, :create, :destroy] do
      resources :ships,    only: [:show, :edit, :update, :index, :new, :create, :destroy] do
        resources :voyages,    only: [:new, :create, :index, :show, :edit, :update]
      end
    end
  end
  resources :agents,  only: [:new, :create, :show, :index, :destroy] do
    member do
      get :manage_ports
    end
    get '/new-employee', :to => 'users#new_ase', :as => :new_ase
    post '/new-employee', :to => 'users#create_ase', :as => :create_ase
  end
  root to: 'static_pages#home'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
end
