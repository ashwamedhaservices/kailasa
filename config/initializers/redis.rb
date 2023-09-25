# frozen_string_literal: true

REDIS = ConnectionPool::Wrapper.new(size: Rails.configuration.redis.pool_size,
                                    timeout: Rails.configuration.redis.timeout) do
  Redis.new(username: Rails.configuration.redis.username,
            host: Rails.configuration.redis.host,
            port: Rails.configuration.redis.port,
            db: Rails.configuration.redis.db,
            ssl: Rails.configuration.redis.ssl)
end
