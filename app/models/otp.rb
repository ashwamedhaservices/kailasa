# frozen_string_literal: true

class Otp
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  field :value,                         type: String
  field :user_id,                       type: Integer
  field :receiver,                      type: String # email, mobile, whatsapp
  field :receiver_type,                 type: String # email, mobile, whatsapp
  field :verified,                      type: Boolean, default: false
  field :otp_type,                      type: String
  field :retry_count,                   type: Integer, default: 0

  index({ user_id: 1 }, background: true)
  index({ receiver: 1 }, background: true)
  index({ otp_type: 1 }, background: true)

  # TODO: move this to concern
  def self.generate!(user, type)
    create({
             user_id: user.id,
             receiver: user.mobile_number,
             receiver_type: 'mobile_number',
             value: otp_value,
             otp_type: type
           }).value
  end

  def self.otp_value
    return 111_111 if Rails.env.development?

    (SecureRandom.random_number(9e5) + 1e5).to_i
  end

  def self.verify!(otp_value, options)
    last_otp = where(user_id: options[:user_id], receiver: options[:receiver], otp_type: options[:otp_type],
                     verified: false).last
    return false unless last_otp

    # value = Rails.env.production? ? otp.value : '111111'
    return last_otp.update(verified: true) if otp_value.to_s == last_otp.value.to_s

    last_otp.update(retry_count: last_otp.retry_count + 1)

    false # can do better here
  end

  def self.otp(options)
    @otp ||= where(
      user_id: options[:user_id],
      receiver: options[:receiver],
      otp_type: options[:otp_type],
      verified: false
    ).last
  end
end
