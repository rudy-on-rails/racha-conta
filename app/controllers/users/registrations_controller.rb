#encoding: utf-8
class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :find_token
  def new
		build_resource({})
  	resource.email = @account_share.email if @account_share
  	respond_with self.resource
  end

  def create
    build_resource(sign_up_params)
    if @account_share
	    resource.email = @account_share.email
	  	resource.skip_confirmation!
	  end
    if resource.save
    	if @account_share
	    	resource.shared_accounts << @account_share.account
	    	@account_share.destroy
	    end
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private
  def find_token
  	if params[:token]
	  	@account_share = AccountShare.find_by_token(params[:token])
			unless @account_share 
				flash[:error] = "Token inválido!"
				redirect_to new_user_session_path
			end
		end
  end
end
