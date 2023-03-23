class ::Notifcation::Sms
  def trigger
    ::Sms::Client.trigger(options)
  end

  private

  def options; end
end
