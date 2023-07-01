# frozen_string_literal: true

REDIS = ConnectionPool::Wrapper.new(size: Rails.configuration.redis.pool_size,
                                    timeout: Rails.configuration.redis.timeout) do
  Redis.new(host: Rails.configuration.redis.host, port: Rails.configuration.redis.port)
end
