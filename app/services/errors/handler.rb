module Errors
  class Handler

    def self.code(error)
      CODES[error]
    end

    CODES = {
      "mobile_number_taken"        => "RE0001",
      "mobile_number_blank"        => "RE0001",
    }

    # TODO
    # CODES.each do |error, code|
    #   define_singleton_method(error) { |*args| { "code" => code, "description" => error, "message" => args[0] || I18n.t(error) } }
    # end
  end

end