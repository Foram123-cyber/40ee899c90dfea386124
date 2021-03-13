Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# resources :users
# get 'api/users', to: 'users#index', as: 'users'
	namespace :api, defaults: { format: :json } do
		resources :users  do
	    collection do
	      get 'typeahead'
	    end
  	end
	end	
end
