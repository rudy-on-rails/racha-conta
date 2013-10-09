#encoding: utf-8
class ExpensesController < AccountsController
	before_filter :find_account
	before_filter :instantiate_types
	
	def new
		@expense = Expense.new		
	end

	def create
		expense_group = @account.find_or_create_a_current_expense_group
		@expense = expense_group.expenses.new(params[:expense])
		@expense.spent_by = current_user
		if @expense.save
			flash[:notice] = "Despesa registrada"
			redirect_to account_path(@account)
		else
			render :new
		end
	end

	def instantiate_types
		@types = ExpenseType.order("name").map{|e| [e.name, e.id]}
	end
end