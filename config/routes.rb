Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #start
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  resources :articles do
    resources :comments
     resources :likes
  end
end
  root 'pages#index'
  get '/about', to: 'pages#about'
  # get '/articles/:id', to: 'articles#show'
  # get '/articles/edit/:id', to: 'articles#edit'
  get 'signup', to: "users#new"
  resources :users, except: [:new]
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

  # devise_for :users, controllers: {
  # sessions: 'users/sessions' }
end
