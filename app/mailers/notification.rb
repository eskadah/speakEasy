class Notification < ActionMailer::Base
  default from: 'from@example.com'

  def send_reminder(speaker_email, id)
  	event_title, @event_start, @event_end = *Event.where(id: id).pluck(:title, :start, :end)
    mail to: user_email, subject: "reminder for #{event_title}"
  end
end
