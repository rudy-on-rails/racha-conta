source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'devise', '3.1.1'
gem 'devise-i18n'
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: [:production, :staging]
gem 'jquery-rails'

group :assets do
  gem 'yui-compressor', '0.9.6'
  gem 'less-rails', '2.3.3'
  gem 'therubyracer', '0.11.4', :platforms => :ruby
  gem 'uglifier', '2.0.1'
end

group :development do
  gem 'open_gem'
  gem 'rspec-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano'
end

group :test do
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'shoulda'
end