# frozen_string_literal: true

module AuthorizationHandler
  extend ActiveSupport::Concern
  include RenderResponse

  attr_accessor :result, :current_user, :current_profile

  # delegate :payload, :success?, to: :result
  delegate :data, to: :result

  def authorize_user!
    unless jwt_token
      return render json: failure(msg: 'Authentication failed', error_code: 'unauthorized'),
                    status: :unauthorized
    end

    @result = Authenticate::Users.call(request, jwt_token)
    unless result.success
      return render json: failure(msg: 'Authentication failed', error_code: 'unauthorized'), status: :unauthorized
    end

    @current_user = User.find(data['id'])
    @current_profile = Profile.find(data['profile_id'])
  end

  def authorize_admin!
    return json_unauthorised(msg: 'Authentication failed') unless jwt_token
    return json_unauthorised(msg: 'Authentication failed') unless Authenticate::Users.call(request, jwt_token).success

    @current_user = User.find_by(data['id'])
    @admin_user = AdminUser.find_by(data['id'])

    json_unauthorised(msg: 'Authentication failed not admin') unless @admin_user&.active?
  end

  def authorize_service!
    service_auth = Authenticate::ServiceToken.new(request).call
    return if service_auth.success?

    render json: render_failure(service_auth.message, 401), status: :unauthorized
  end

  private

  def jwt_token
    (request.headers['Authorization'] || '').split.last
  end
end
