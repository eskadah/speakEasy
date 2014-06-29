require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "send_reminder" do
    mail = Notification.send_reminder
    assert_equal "Send reminder", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
