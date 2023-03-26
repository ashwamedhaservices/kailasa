module Users
  module Validatable
    extend ActiveSupport::Concern
    # this format expect password to be atleast 8 char long.
    # atleast 1 digit, 1 lower or upper case charactor
    PASSWORD_FORMAT = /\A(?=.*\d)(?=.*[a-zA-Z]).{8,}/x

    # PASSWORD_FORMAT = /\A
    #     (?=.{8,})          # Must contain 8 or more characters
    #     (?=.*\d)           # Must contain a digit
    #     (?=.*[a-zA-Z])     # Must contain a lower/upper case character
    #     # (?=.*[a-z])        # Must contain a lower case character
    #     # (?=.*[A-Z])        # Must contain an upper case character
    #     # (?=.*[[:^alnum:]]) # Must contain a symbol
    #   /x

    included do
      # associations

      # delegations

      # validations
      validates :mobile_number,
                presence: true,
                uniqueness: { message: 'has already been registered, please login.' }
      # validates :password,
      #           presence: true,
      #           format: { with: PASSWORD_FORMAT, message: 'is not longer or missing numbers or characters' },
      #           on: :create
      validates :passwd,
                presence: true,
                format: { with: PASSWORD_FORMAT, message: 'is not longer or missing numbers or characters' },
                on: :create
    end
  end
end
