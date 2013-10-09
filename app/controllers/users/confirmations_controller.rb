#encoding: utf-8
class Users::ConfirmationsController < Devise::ConfirmationsController
  # def new
  # end

  # def create
  #   super
  # end

  def show
  	self.resource = resource_class.confirm_by_token(params[:confirmation_token])
  	if resource.errors.any?
  		flash[:error] = "Token inválido ou expirado!"
  		redirect_to new_user_session_path
  	else
  		flash[:notice] = "Confirmação realizada com sucesso. Bem-vindo!"
  		sign_in(resource)
  		redirect_to root_path
  	end
  end
end
