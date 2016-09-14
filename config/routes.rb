Rails.application.routes.draw do

  get 'sessions/new'

  root 'welcome#index'
  
  get 'signup' =>  'users#new'
  #get 'show' =>  'users#show'
  post 'create' => 'user#create'
  get 'edit' =>  'users#edit'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'login' => 'sessions#create'
  get '/:name/posts' => 'users#show' , :as => :user
  resources :posts,          only: [:create, :destroy]
  
  #Allows /user/posts to show users posts
  #May probably be optimized
  resources :users, param: :name, except: :show
  get '/:name/posts' => 'users#show' , :as => :user_show
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
