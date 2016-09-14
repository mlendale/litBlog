Rails.application.routes.draw do

  get 'sessions/new'

  root 'welcome#index'
  
  get 'signup' =>  'users#new'
  get 'show' =>  'users#show'
  get 'edit' =>  'users#edit'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'login' => 'sessions#create'
  resources :posts,          only: [:create, :destroy]

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
