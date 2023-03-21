module AuthorizationHandler
  extend ActiveSupport::Concern
  include RenderResponse
  
  attr_accessor :result, :current_user
  delegate :payload, :success?, to: :result

  def authorize_user!
    # return render json: { status: 'failure', error: 'Authentication failed' }, status: :unauthorized unless jwt_token
    return render json: render_failure('Authentication failed', 401), status: :unauthorized unless jwt_token

    @result = Authenticate::Users.call(jwt_token)
    if success?
      @current_user = user
    else
      # TODO use failure
      return render json: { status: 'failure', error: payload }, status: http_status
    end
  end

  def authorize_admin!
    authorize_user!
    @current_user = result.payload
    unless current_user.admin?
      # TODO use failure
      render json: render_failure('Unautherized access!', 401), status: :unauthorized
    end
  end

  def authorize_service!
    service_auth = Authenticate::ServiceToken.new(request).call
    unless service_auth.success?
      render json: render_failure(service_auth.message, 401), status: :unauthorized
    end
  end

  private

  def jwt_token
    (request.headers['Authorization'] || '').split.last
  end

  def user
    User.find(payload[:user_id])
  end
end
