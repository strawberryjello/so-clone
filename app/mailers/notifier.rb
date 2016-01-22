class Notifier < ApplicationMailer

  def forgot_password to, pass, sent_at = Time.now
    @pass = pass
    mail(
         :subject => 'SoClone - Forgot password',
         :to => to,
         :from => 'no-reply@soclone.com',
         :date => sent_at
         )
  end

end
