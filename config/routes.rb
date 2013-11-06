SampleApp::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :shipping_companies,  only: [:new, :create, :show, :index, :destroy] do
    match '/new-employee', :to => 'users#new_sce', :as => :new_sce, via: 'get'
    match '/new-employee', :to => 'users#create_sce', :as => :create_sce, via: 'post'
  end
  resources :agents,  only: [:new, :create, :show, :index, :destroy] do
    match '/new-employee', :to => 'users#new_ase', :as => :new_ase, via: 'get'
    match '/new-employee', :to => 'users#create_ase', :as => :create_ase, via: 'post'
  end
  root to: 'static_pages#home'
#  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
#  match '/new-shipping-company', :to => 'shipping_companies#new', :as => :new_shipping_company, via: 'get'
#  match '/new-agent-supplier', :to => 'agents#new', :as => :new_agent, via: 'get'
end
