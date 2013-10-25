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
  		get :account_history
	  	get :share
	  	get :close_current_group
	  	put :set_sharing
	  	delete :remove_sharing
	  end
	  
  	resources :expenses, except: :index
  	resources :account_shares, only: :destroy
  end

  resources :expense_groups, only: [:show]

  namespace :api do
  	resources :expenses, only: [] do
  		collection do
  			get 'categories'
  		end
  	end
  	resources :expense_groups, only: [] do
  		member do
  			get 'total_by_category'
  		end
  	end
  end
end
