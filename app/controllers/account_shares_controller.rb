#encoding: utf-8
class AccountSharesController < AccountsController
	before_filter :find_account
	
	def destroy
		@account_share = @account.account_shares.find(params[:id])
		@account_share.destroy
		flash[:notice] = "Compartilhamento desfeito com sucesso"
		redirect_to existent_sharings_account_path(@account)
	end
end