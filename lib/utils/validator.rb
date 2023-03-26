# frozen_string_literal: true

module Utils
  class Validator
    # may be use some gem or move all regexes to a file and load it
    INDIAN_MOBILE_REGEX = /\A[4-9]{1}[0-9]{9}\z/.freeze

    def self.email_valid?(email)
      email_regex = /^([\w-]+(?:\.[\w-]+)*(?:\+[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
      (email =~ email_regex)
    end

    def self.password_valid?(password)
      (password.length >= 8) && (password.length < 128)
    end

    def self.valid_indian_phone_number?(phone_number)
      phone_number.match(INDIAN_MOBILE_REGEX).present?
    end

    def self.non_indian_mobile_number?(number)
      !(number[0..2].eql?('+91') && valid_indian_phone_number?(number[3..number.length - 1]))
    end
  end
end
