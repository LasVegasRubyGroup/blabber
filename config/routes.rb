Blabber::Application.routes.draw do

  resources :blabs


	root :to => 'pages#landing'

	get 'signup', to: 'users#new', as: 'signup' 
	resources :users, only: [:create, :show]

	get 'signin', to: 'sessions#new', as: 'signin'
	get 'signout', to: 'sessions#destroy', as: 'signout' 
	resources :sessions, only: [:create]

end