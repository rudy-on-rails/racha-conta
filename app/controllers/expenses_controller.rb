#encoding: utf-8
class ExpensesController < AccountsController
	before_filter :find_account
	skip_before_filter :validate_user_is_owner_of_the_account!
	before_filter :find_expense, only: [:edit, :update, :destroy]
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

	def edit
	end

	def update
		if @expense.update_attributes(params[:expense])
			flash[:notice] = "Despesa atualizada"
			redirect_to expense_group_path(@expense.expense_group)
		else
			render :edit
		end
	end

	def destroy
		@id = @expense.id		
		@expense.destroy
	end

	private
	def find_expense
		@expense = Expense.find(params[:id])
		validate_user_can_change_expense!
	end
end