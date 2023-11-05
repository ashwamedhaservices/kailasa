# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get '/health_check', to: proc { [200, {}, ['success']] }
  draw :api_v1
  draw :admin_api_v1
  draw :partner_api_v1
  draw :interface_api_v1
  draw :accounts

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'some_user' && password == 'some_password'
  end
  mount Sidekiq::Web => '/sidekiq'
end
