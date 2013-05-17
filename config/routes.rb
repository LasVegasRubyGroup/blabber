Blabber::Application.routes.draw do

	root :to => 'site#index'

	get 'signup', to: 'users#new', as: 'signup' 
	resources :users, only: [:create]

	get 'signin', to: 'sessions#new', as: 'signin'
	get 'signout', to: 'sessions#destroy', as: 'signout' 
	resources :sessions, only: [:create]

end