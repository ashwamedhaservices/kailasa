# frozen_string_literal: true

sidekiq_configs = Rails.configuration.sidekiq

Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_configs.redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_configs.redis_url }
end
