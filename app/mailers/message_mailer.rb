class MessageMailer < ApplicationMailer
  default from: "support@cordis-dev.com"

  def message_to_user(send_user, receive_user)
    @sender_user = send_user
    @receive_user = receive_user
    mail(
      subject: "#{@sender_user.name}さんから新着メッセージが届いています！｜cordis",
      to: @receive_user.email
    )
  end
end
