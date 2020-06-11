Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #start
  root 'index#first'
  get '/ammaar', to: 'index#ammaar'
  get '/about', to: 'index#about_us'
  get '/developers', to: 'index#developer'
end
