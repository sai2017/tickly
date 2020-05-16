class NotificationFromBareeMailer < ApplicationMailer
  default from: '"Baree" <info@baree.jp>'

  def all_notify(users, title, content)
    @content = content
    mail(
      subject: title,
      to: users.map{|user| user.email}
    )
  end
end
