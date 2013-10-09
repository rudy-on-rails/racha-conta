module Sharing
	class AccountSharing
		class AccountAlreadySharedError < Exception ; end
		def	initialize(account, user_sharing)
			@account = account
			@user_sharing = user_sharing
		end

		def share_with(user_email)
			user = User.find_by_email(user_email)			
			if user.nil?
				raise AccountAlreadySharedError if AccountShare.find_by_account_id_and_email(@account.id, user_email)
				account_share = AccountShare.create(:email => user_email, :account => @account)
				SharingAccountMailer.share_with_unexistent_user(account_share, @user_sharing).deliver
			else
				raise AccountAlreadySharedError if @account.shared_with?(user)
				@account.shared_with << user
				SharingAccountMailer.share_with_existent_user(@account, user, @user_sharing).deliver
			end
		end
	end
end