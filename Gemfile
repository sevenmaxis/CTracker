source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem 'sqlite3'
gem 'savon'
gem 'nokogiri'

group :development do
  gem 'database_cleaner'
end

group :test do
  gem 'cucumber'
  gem 'cucumber-rails', :require => false
end

group :development, :test do
	gem "rspec-rails", "~> 2.0"
	gem 'guard-rspec'
	gem 'rb-inotify', '~> 0.8.8'
	gem 'launchy'
	gem "capybara", '~> 2.0.2'
	gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
end	