SampleApp::Application.routes.draw do
  mount Mercury::Engine => '/'
  Mercury::Engine.routes
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  #resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :operations,    only: [:create, :destroy]
  resources :shipping_companies,  only: [:new, :create, :show, :index, :destroy] do
    get '/new-employee', :to => 'users#new_sce', :as => :new_sce
    post '/new-employee', :to => 'users#create_sce', :as => :create_sce
    member { put :mercury_update }
    resources :pages, only: [:new, :create] do
      post :sort, on: :collection
    end
    resources :fleets,    only: [:show, :edit, :update, :index, :new, :create, :destroy] do
      resources :ships,    only: [:show, :edit, :update, :index, :new, :create, :destroy] do
        get 'list' , :to => 'ships#list'
        resources :voyages,    only: [:new, :create, :index, :show, :edit, :update] do
          patch '/accept', :to => 'voyages#accept'
          resources :voyages_port,    only: [:new, :create, :update] do
            end
          resources :needs,    only: [:new, :create] do
            resources :offers, only: [:new, :create, :update] do
              patch '/accept', :to => 'offers#accept'
            end
          end
        end
      end
    end
  end
  resources :agents,  only: [:new, :create, :show, :index, :destroy] do
    member { put :mercury_update }
    resources :agent_pages, only: [:new, :create] do
      post :sort, on: :collection
    end
    member do
      get :manage_ports
    end
    get '/new-employee', :to => 'users#new_ase', :as => :new_ase
    post '/new-employee', :to => 'users#create_ase', :as => :create_ase
  end
  
  resources :messages do
    #get :autocomplete_recipients, :on => :collection
  end
  
  resources :conversations
  
  resources :notifications

  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end
 
  get "refresh-navbar" , :to => "conversations#refresh_navbar", :as => :refresh_navbar, :constraints => OnlyAjaxRequest.new
  get "refresh-latest-messages" , :to => "conversations#refresh_latest", :as => :refresh_latest_conversations, :constraints => OnlyAjaxRequest.new
  get "refresh-messages-feed" , :to => "conversations#refresh_feed", :as => :refresh_feed_conversations, :constraints => OnlyAjaxRequest.new
  get "notifications/small/:id" , :to => "notifications#show_small", :as => :show_small_conversations, :constraints => OnlyAjaxRequest.new
  #post "conversations/small/:id" , :to => "conversations#update_small", :as => :update_small_conversations, :constraints => OnlyAjaxRequest.new

  root to: 'static_pages#home'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get "/search" , :to => "static_pages#search", :as => :search
  get "/search_mailbox" , :to => "conversations#search", :as => :search_mailbox
  
  get :autocomplete_recipients, :to => 'messages#recipients'
  
end
