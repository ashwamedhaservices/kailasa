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
    self.create({
      user_id: user.id,
      receiver: user.mobile_number,
      receiver_type: 'mobile_number',
      value: SecureRandom.random_number(900000),
      otp_type: type,
    }).value
  end

  def self.verify!(otp_value, options)
    otp = self.otp(options)
    value = Rails.env.production? ? otp.value : '111111'
    if otp_value.to_s == value
      return otp.update(verified: true)
    else
      otp.update(retry_count: otp.retry_count + 1)
    end
    false # can do better here
  end

  def self.otp(options)
    @otp ||= self.where(
      user_id: options[:user_id],
      receiver: options[:receiver],
      otp_type: options[:otp_type],
      verified: false
    ).limit(1).last
  end
end
