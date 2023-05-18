# frozen_string_literal: true

module ::Notification
  class Base
    # class Base

    MEDIUMS = {
      sms: 'Sms',
      email: 'Email',
      whatsapp: 'WhatsApp'
    }.freeze

    attr_accessor :notify_options, :user

    delegate :email, :mobile_number, :salutaion, to: :user

    def initialize(receiver_id:, notify_options:)
      @notify_options = notify_options
      @user = User.find(receiver_id)
    end

    def self.call(**args)
      new(**args).process
    end

    def process
      prefered_medium.map do |pref|
        MEDIUMS[pref].constantize.trigger
      end
    end

    private

    def payload; end
  end
end
# end
