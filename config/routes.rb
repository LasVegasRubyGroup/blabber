Blabber::Application.routes.draw do

	root :to => 'site#index'

	get 'signup', to: 'users#new', as: 'signup' 
	resources :users, only: [:create]

end