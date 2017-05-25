Rails.application.routes.draw do
  devise_for :users, except: [:edit, :destroy, :update]
  resources :reports, only: [:index]
  get '/reports/view' => 'reports#view'
  get '/tasks/notify_assigned', to: 'tasks#notify_assigned'
  post 'tasks/notified' => 'tasks#notified'
  resources :tasks, except: [:edit, :show, :new] do
  	member do
     patch :startTask
     patch :complete
  	end
  end

  resources :user, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "tasks#index"
end
