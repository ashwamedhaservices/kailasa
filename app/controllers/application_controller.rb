class ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthorizationHandler
  include ActionController::MimeResponds
  include RenderResponse
end
