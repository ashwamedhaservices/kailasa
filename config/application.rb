# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

require_relative '../lib/middlewares/request_response_logger'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kailasa
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.time_zone = 'Chennai'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.eager_load_paths << Rails.root.join('lib')
    config.payouts = config_for(:payouts)
    config.product_details = config_for(:product_details)
    config.redis = config_for(:redis)
    config.sidekiq = config_for(:sidekiq)
    config.generators do |g|
      g.orm :active_record
    end

    config.middleware.use Middlewares::RequestResponseLogger
  end
end
