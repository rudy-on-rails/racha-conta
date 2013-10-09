Devise.setup do |config|
  config.secret_key = '2953d6f9ef991464d0bb56f16ee8817c1367c481ca1e2d45770f7cb7ac023e6ac5c67c36f2f0f1d07be7e7357e8f04903202d5c7a09bce8e3a9dfc758321ceeb'
  config.mailer_sender = 'admin@rachaconta.com.br'
  config.mailer = SharingAccountMailer
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 6..128
  config.reset_password_within = 6.hours
  config.timeout_in = 12.hours
  config.sign_out_via = :delete
end
