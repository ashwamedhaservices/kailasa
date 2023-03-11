class Interfaces::Api::V1::ApplicationController < ::ApplicationController
  before_action :authenticate_service_token!
end
