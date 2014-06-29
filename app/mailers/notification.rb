class Notification < ActionMailer::Base
  default from: 'from@example.com'

  def send_reminder(user_email,event_title,event_start,event_end)
    @event_start = event_start
    @event_end = event_end
    mail to: user_email, subject: "reminder for #{event_title}"
  end
end
