module Errors
  class Handler
    def self.code(error)
      CODES[error]
    end

    CODES = {
      'required_params_missing' => 'IR0001', # invalid request
      'mobile_number_taken' => 'RE0002', # Register Error
      'mobile_number_blank' => 'RE0003', # Register Error
      'mobile_verification_pending' => 'RE0004', # Register Error
      'wrong_otp' => 'WD0001', # Wrong Data
      'record_not_found' => 'WD0001', # Wrong Data
      'invalid_credentials' => 'SE0001', # Session Error
      'unauthorized' => 'SE0002', # Session Error
      'invalid_request' => 'RE0001', # request error
      'standard_error' => 'IE0001' # internal error
    }

    # TODO
    # CODES.each do |error, code|
    #   define_singleton_method(error) { |*args| { "code" => code, "description" => error, "message" => args[0] || I18n.t(error) } }
    # end
  end
end
