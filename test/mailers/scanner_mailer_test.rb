require 'test_helper'

class ScannerMailerTest < ActionMailer::TestCase
  test "rates_notification" do
    mail = ScannerMailer.rates_notification
    assert_equal "Rates notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
