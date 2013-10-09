require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module SharingAccount
  class Application < Rails::Application
  	config.generators do |g|
      g.stylesheets     false
      g.test_framework  :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.i18n.default_locale = :"pt-BR"
    config.active_support.escape_html_entities_in_json = true
    config.active_record.whitelist_attributes = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    if Rails.env.development?
    	config.action_mailer.default_url_options = {
	    	host: "localhost:3000"
  	  }
  	else
  		config.action_mailer.default_url_options = {
	    	host: "rachaaconta.herokuapp.com"
  	  }
  	end
  end
end
