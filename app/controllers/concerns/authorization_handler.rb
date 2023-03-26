# frozen_string_literal: true

module AuthorizationHandler
  extend ActiveSupport::Concern
  include RenderResponse

  attr_accessor :result, :current_user

  # delegate :payload, :success?, to: :result
  delegate :data, to: :result

  def authorize_user!
    return render json: failure('Authentication failed', 401), status: :unauthorized unless jwt_token

    @result = Authenticate::Users.call(request, jwt_token)
    return render json: { status: 'failure', error: @result }, status: :unauthorized unless result.success

    @current_user = User.find(data['id'])
  end

  def authorize_admin!
    authorize_user!
    return if current_user.admin?

    # TODO: use failure
    render json: failure('Unautherized access!', 401), status: :unauthorized
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
