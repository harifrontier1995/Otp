class SendPinWorker
  include Sidekiq::Worker

  def perform(phone_number_with_code)
    account_sid = "ACba261530abf7a184a71e0cd92716a913"
    auth_token = "b8c1ee25f0f78876319079be1aa32bf0"
    service_sid = "VA3897d8a3e095fe4e21782d02494d4d69"

    client = Twilio::REST::Client.new(account_sid, auth_token)
    verification_service = client.verify.services(service_sid)

    verification_service
      .verifications
      .create(to: phone_number_with_code, channel: 'sms')
  end
end