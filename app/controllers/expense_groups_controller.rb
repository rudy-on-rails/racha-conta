class ExpenseGroupsController < AuthenticatedController
	before_filter :find_account
	before_filter :validate_account_access!

	def show
		
	end

	def find_account
		@expense_group = ExpenseGroup.find(params[:id])
		@account = @expense_group.account
	end

	def validate_account_access!
		validate_user_can_access_account!
	end
end