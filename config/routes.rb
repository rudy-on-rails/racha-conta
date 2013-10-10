#encoding: utf-8
SharingAccount::Application.routes.draw do
  devise_for :users, :controllers => {
  	:confirmations => "Users::Confirmations",
  	:registrations => "Users::Registrations"
  }

  root :to => 'accounts#index'
  
  resources :accounts do
  	member do
  		get :existent_sharings
	  	get :share
	  	get :close_current_group
	  	put :set_sharing
	  	delete :remove_sharing
	  end
	  
  	resources :expenses, except: :index
  	resources :account_shares, only: :destroy
  end

  namespace :api do
  	resources :expenses, only: [] do
  		collection do
  			get 'categories'
  		end
  	end
  end
end
