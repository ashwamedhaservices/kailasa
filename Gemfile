# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use Mongo as the secondary database
gem 'mongoid'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use hiredis to get better performance than the "redis" gem
gem 'hiredis'
gem 'redis'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

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

# for encrypting data
gem 'symmetric-encryption'

# PDF response
gem 'wicked_pdf', '1.4.0'
gem 'wkhtmltopdf-binary'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Rails application performance monitoring
gem 'scout_apm'

# Async and background jobs
gem 'sidekiq'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'meta_request'
  gem 'safe_query'
end

group :development do
  gem 'listen'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'spring'
  gem 'spring-watcher-listen'

  # Add column hint in the rails models
  gem 'annotate'

  # rubocop for formatting the code base
  gem 'rubocop'
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false

  # For navigating through the code base
  gem 'solargraph'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
