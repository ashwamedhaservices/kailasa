module AuthenticatesWithJwt
  extend ActiveSupport::Concern
  attr_accessor :result, :current_user
  delegate :payload, :success?, to: :result

  def authorize_user!
    return render json: { status: 'failure', error: 'Authentication failed' }, status: :unauthorized unless jwt_token

    @result = Authenticate::Users.call(jwt_token)
    if success?
      @current_user = user
    else
      return render json: { status: 'failure', error: payload }, status: http_status
    end
  end

  def authorize_admin!
    authorize_user!
    @current_user = result.payload
    unless current_user.admin?
      render json: { status: 'failure', message: 'Unautherized access!' }, status: :unauthorized
    end
  end

  def authorize_service_token!
    service_auth = Authenticate::ServiceToken.new(request).call
    unless service_auth.success?
      render json:   { status: 'failure', error: service_auth.message },
             status: service_auth.http_status
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
