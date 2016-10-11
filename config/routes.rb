Rails.application.routes.draw do

  get 'sessions/new'

  root 'welcome#index'
  
  get 'signup' =>  'users#new'
  #get 'show' =>  'users#show'
  #post 'create' => 'user#create'
  #get 'edit' =>  'users#edit'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'login' => 'sessions#create'
  get '/:name/posts' => 'users#show' , :as => :user
  
  #May be useful to define a clearer url for posts
  resources :posts,          only: [:create, :edit, :destroy]
  match '/posts/:id/edit', to: 'posts#edit', via: :post
  match '/posts/:id', to: 'posts#update', via: :patch, :as => :update_post
  
  
  #Allows /user/posts to show users posts
  #May probably be optimized
  resources :users, param: :name, except: [:show, :edit, :update]
  get '/:name/posts' => 'users#show' , :as => :user_show
  get '/:name/edit' => 'users#edit' , :as => :user_edit
  match '/:name/posts', to: 'users#update', via: :patch
  #match '/:name/posts', to: 'users#show', via: :post
  
  #api
  namespace :api do
    namespace :v1 do
    match '/login', to: 'sessions#create', via: :post
    resources :users, only: [:index, :create, :show, :update, :destroy]
    resources :posts, only: [:index, :create, :show, :update, :destroy]
    resources :sessions, only: [:create]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
