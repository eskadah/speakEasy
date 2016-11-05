require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "send_reminder" do
    mail = Notification.send_reminder "to@example.org", "An Event", Time.current,Time.current
    assert_equal "reminder for An Event", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
  end

end
