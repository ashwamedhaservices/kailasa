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

    assingn_request_variables(user_id: data['id'], profile_id: data['profile_id'])
  end

  def authorize_admin!
    return json_unauthorised(msg: 'Authentication failed') unless jwt_token
    return json_unauthorised(msg: 'Authentication failed') unless Authenticate::Users.call(request, jwt_token).success

    assingn_request_variables(user_id: data['id'], admin_id: data['admin_user_id'])
    json_unauthorised(msg: 'Authentication failed not admin') unless @admin_user&.active?
  end

  # not yet implemented propely so would need to check this out
  def authorize_service!
    service_auth = Authenticate::ServiceToken.new(request).call
    return if service_auth.success?

    render json: render_failure(service_auth.message, 401), status: :unauthorized
  end

  private

  def jwt_token
    (request.headers['Authorization'] || '').split.last
  end

  def assingn_request_variables(user_id: nil, profile_id: nil, admin_id: nil, service_id: nil) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    if user_id
      @current_user = User.find_by(id: data['id'])
      Rails.logger.push_tags("user_id: #{@current_user.id}")
    end

    if profile_id
      @current_profile = Profile.find_by(id: data['id'])
      Rails.logger.push_tags("profile_id: #{@current_profile.id}")
    end

    if admin_id
      @admin_user = AdminUser.find_by(id: data['id'])
      Rails.logger.push_tags("admin_user_id: #{@admin_user.id}")
    end

    if service_id
      # authorised service
      Rails.logger.push_tags("service_name: #{service_id}")
    end

    Rails.logger.info('request variables assigned')
  end
end
