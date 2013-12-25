#encoding: utf-8
class AccountsController < AuthenticatedController
	require_dependency "expense_totals_by_person"
	require_dependency "account_sharing"
	before_filter :find_account, except: [:index, :new, :create]
	before_filter :validate_user_is_owner_of_the_account!, only: [:destroy, :remove_sharing, :existent_sharings, :share, :set_sharing, :close_current_group]
	
	def	index
		@my_accounts = current_user.accounts_shared_and_created
	end

	def new
		@account = Account.new
	end

	def create
		@account = current_user.accounts_created.new(params[:account])
		if @account.save
			redirect_to existent_sharings_account_path(@account)
		else
			render :new
		end
	end

	def update
		if @account.update_attributes(params[:account])
			redirect_to existent_sharings_account_path(@account)
		else
			render :edit
		end
	end

	def destroy
		@id = @account.id
		unless @account.created_by?(current_user)
			flash[:error] = "Apenas o usuário que criou esta conta pode excluí-la!"
			render "shared/flash_message"
		else
			begin
				@account.destroy	
			rescue ActiveRecord::DeleteRestrictionError => e
				flash[:error] = "Esta conta possui despesas e não pode ser excluída!"
				render "shared/flash_message"
			end
		end
	end

	def remove_sharing
		user = User.find(params[:user_id])
		@account.remove_sharing(user)
		flash[:notice] = "Compartilhamento removido com sucesso"
		redirect_to existent_sharings_account_path(@account)
	end

	def existent_sharings
	end

	def share
	end

	def set_sharing
		begin
			Sharing::AccountSharing.new(@account, current_user).share_with(params[:email])
			flash[:notice] = "Conta compartilhada com sucesso"
		rescue Sharing::AccountSharing::AccountAlreadySharedError
			flash[:error] = "Esta conta já está compartilhada com esta pessoa!"
		end
		redirect_to existent_sharings_account_path(@account)	
	end

	def show
		@totals_by_person = Analytics::ExpenseTotalsByPerson.new(@account).sumarize_total_spent_by_person
	end

	def edit
		unless @account.created_by?(current_user)
			flash[:error] = "Apenas o usuário que criou esta conta pode modificá-la!"
			redirect_to root_path
		end
	end

	def close_current_group
		flash[:notice] = "Período encerrado com sucesso!"
		@account.close_current_group!
		redirect_to account_path(@account)
	end

	def account_history
		
	end

	private
	def find_account
		@account = Account.find(params[:account_id]) if params[:account_id]
		@account = Account.find(params[:id]) if params[:id] and @account.nil?
		validate_user_can_access_account!
	end
end