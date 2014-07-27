SampleApp::Application.routes.draw do
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
    resources :fleets,    only: [:show, :edit, :update, :index, :new, :create, :destroy] do
      resources :ships,    only: [:show, :edit, :update, :index, :new, :create, :destroy] do
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
 
  get "refresh-latest-messages" , :to => "conversations#refresh_latest", :as => :refresh_latest_conversations, :constraints => OnlyAjaxRequest.new
  get "refresh-messages-feed" , :to => "conversations#refresh_feed", :as => :refresh_feed_conversations, :constraints => OnlyAjaxRequest.new
  get "conversations/small/:id" , :to => "conversations#show_small", :as => :show_small_conversations, :constraints => OnlyAjaxRequest.new
  post "conversations/small/:id" , :to => "conversations#update_small", :as => :update_small_conversations, :constraints => OnlyAjaxRequest.new

  root to: 'static_pages#home'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  
  get :autocomplete_recipients, :to => 'messages#recipients'
  
end
