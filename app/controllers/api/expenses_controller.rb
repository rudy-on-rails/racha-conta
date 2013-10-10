module Api
	class ExpensesController < ApplicationController
		require_dependency 'expense_category_repository'

		def categories			
			render :json => Repositories::ExpenseCategoryRepository.new.categories_for(current_user)
		end
	end
end