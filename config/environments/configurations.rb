# frozen_string_literal: true

def configure_redis_cache
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  redis_configs = Rails.configuration.redis
  return unless redis_configs.url

  config.action_controller.perform_caching = true
  config.cache_store = :redis_cache_store, redis_cache_store_options(redis_configs)
end

def redis_cache_store_options(configs)
  {
    url: configs.url,
    connect_timeout: configs.connect_timeout, # Defaults to 20 seconds
    read_timeout: configs.read_timeout, # Defaults to 1 second
    write_timeout: configs.write_timeout, # Defaults to 1 second
    reconnect_attempts: configs.reconnect_attempts # Defaults to 0
  }
end
