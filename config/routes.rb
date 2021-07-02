Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'users/:id/tasks', to: 'tasks#index', as: :task_index
  get 'users/:id/tasks/new', to: 'tasks#new', as: :task_new
  post 'users/:id/tasks/new', to: 'tasks#create', as: :task_create 
  get 'users/:id/tasks/:task_id', to: 'tasks#show', as: :task_show
  post 'users/:id/tasks/:task_id', to: 'tasks#update', as: :task_update
  delete 'users/:id/tasks/:task_id', to: 'tasks#destroy', as: :task_destroy
  get 'users/:id/tasks/:task_id/edit', to: 'tasks#edit', as: :task_edit
  
  resources :users
end
