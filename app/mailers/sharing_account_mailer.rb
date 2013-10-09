#encoding: utf-8
class SharingAccountMailer < Devise::Mailer
  layout "mail_layout"
  default from: %("Racha Conta" <admin@rachaconta.com.br>)

  def share_with_unexistent_user(account_share, user_sharing)
  	@account_share = account_share
  	@user_sharing = user_sharing
  	mail(:to => account_share.email, :subject => "Um usuário do Racha Conta deseja compartilhar uma conta com você")
  end

  def share_with_existent_user(account, user, user_sharing)
		@account = account
		@user = user
  	@user_sharing = user_sharing
  	mail(:to => user.email, :subject => "Nova conta compartilhada por " + user_sharing.name)
  end
end