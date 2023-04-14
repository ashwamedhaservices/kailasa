module Errors
  class Handler
    def self.code(error)
      CODES[error]
    end

    CODES = {
      'required_params_missing' => 'IR0001', # invalid request
      'mobile_number_taken' => 'RE0001', # Register Error
      'mobile_number_blank' => 'RE0001', # Register Error
      'mobile_verification_pending' => 'RE0002', # Register Error
      'wrong_otp' => 'WD0001', # Wrong Data
      'record_not_found' => 'WD0001', # Wrong Data
      'invalid_credentials' => 'SE0001' # Session Error

    }

    # TODO
    # CODES.each do |error, code|
    #   define_singleton_method(error) { |*args| { "code" => code, "description" => error, "message" => args[0] || I18n.t(error) } }
    # end
  end
end
