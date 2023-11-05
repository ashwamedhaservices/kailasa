sidekiq_configs = Rails.configuration.redis

Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_configs.redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_configs.redis_url }
end
