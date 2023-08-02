if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDISCLOUD_URL'] }
    # config.poll_interval = 1
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDISCLOUD_URL"]}
  end

  ENV['REDIS_PROVIDER'] = ENV['REDISCLOUD_URL'] || '127.0.0.1:6379'
else
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDISCLOUD_URL'] }
    # config.poll_interval = 1
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDISCLOUD_URL"]}
  end

  ENV['REDIS_PROVIDER'] = ENV['REDISCLOUD_URL'] || '127.0.0.1:6379'
end

require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Extensions.enable_delay!

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_USERNAME'], ENV['SIDEKIQ_PASSWORD']]
end
