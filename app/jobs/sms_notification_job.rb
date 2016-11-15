class SmsNotificationJob < ApplicationJob
  queue_as :default

  def perform(title, phone_number)
    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: phone_number,
      body: "Hello, this is a friendly reminder that #{title} starts less than a day from now"
    )
  end
end
