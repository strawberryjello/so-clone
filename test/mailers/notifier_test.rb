require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  def setup
    @to = 'test@test.com'
    @pass = 'pass'

    @email = Notifier.forgot_password(@to, @pass).deliver_now
  end

  test 'notifier: email sent' do
    assert_not ActionMailer::Base.deliveries.empty?
  end

  test 'notifier: verify from address' do
    assert_equal ['no-reply@soclone.com'], @email.from
  end

  test 'notifier: verify recipient' do
    assert_equal [@to], @email.to
  end

  test 'notifier: verify subject' do
    assert_equal 'SoClone - Forgot password', @email.subject
  end

end
