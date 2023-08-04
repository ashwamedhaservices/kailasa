# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.4.2'
# Use mysql as the database for Active Record
gem 'mysql2'

# Use Mongo as the secondary database
gem 'mongoid'

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'connection_pool'
gem 'redis'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# authentication
gem 'jwt'

# design patterns
gem 'interactor', '~> 3.0'

# state machine
gem 'aasm', '~> 5.1', '>= 5.1.1'

# serializer
gem 'jsonapi-serializer'

# generates friendly id
gem 'friendly_id', '~> 5.4.0'

# aws
gem 'aws-sdk-s3'

# Payment gateways -> supports PAYU and HDFC PAYPAL-> INDIA
# https://github.com/activemerchant/active_merchant
# gem 'activemerchant'

gem 'paper_trail'
gem 'strong_migrations'
gem 'symmetric-encryption'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'brakeman'
  # gem 'bullet'
  gem 'bundler-audit'
  gem 'safe_query', '~> 0.1.0'
  # gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'meta_request'
  gem 'rack-mini-profiler', '~> 3.0'
  gem 'scout_apm'
  gem 'solargraph'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'annotate'
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'sidekiq', '~> 7.1'
