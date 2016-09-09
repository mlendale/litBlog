Rails.application.routes.draw do
  get 'users/new'

  get 'users/edit'

  get 'users/show'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
