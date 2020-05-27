class NotificationFromBareeMailer < ApplicationMailer
  default from: '"Tickly" <info@tickly.jp>'

  def all_notify(user, title, content)
    @content = content
    mail(
      subject: title,
      to: user.email
    )
  end
end
