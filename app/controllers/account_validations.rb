#encoding: utf-8
module AccountValidations
	def validate_user_can_access_account!
		unless current_user.accounts_shared_and_created.include?(@account)
			raise InsufficientPermissionError, "Você não possui permissão de acesso a esta conta!"
		end			
	end

	def validate_user_is_owner_of_the_account!
		unless @account.created_by?(current_user)
			raise InsufficientPermissionError, "Apenas o usuário que criou a conta pode realizar esta ação!"
		end
	end

	def validate_user_can_change_expense!
		unless @expense.can_be_modified_by?(current_user)
			raise InsufficientPermissionError, "Apenas o usuário que criou a despesa e administradores da conta podem realizar esta ação!"
		end
	end
end