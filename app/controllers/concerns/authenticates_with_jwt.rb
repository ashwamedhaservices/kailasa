module AuthenticatesWithJwt
  extend ActiveSupport::Concern

  def authenticate_user!
    return render json: { status: 'failure', error: 'Authentication failed' }, status: :unauthorized unless jwt_token

    result = Authenticate::Users.call(jwt_token)
    if result.success?
      @current_user = result.payload
    else
      render json: { status: 'failure', error: result.payload }, status: result.http_status
    end
  end

  def authenticate_admin!
    result = Authenticate::AdminUsers.new(jwt_token).call
    if result.success?
      @current_user = result.payload
    else
      render json: { status: 'failure', error: result.message }, status: result.http_status
    end
  end

  def authenticate_service_token!
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
end
