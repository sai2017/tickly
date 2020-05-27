class MessageMailer < ApplicationMailer
  default from: '"Tickly" <info@tickly.jp>'

  def message_to_user(send_user, receive_user)
    @sender_user_name = send_user.person.profile.name
    @receive_user_name = receive_user.person.profile.name
    mail(
      subject: "【Baree】#{@sender_user_name}さんから新着メッセージが届いています！",
      to: receive_user.email
    )
  end
end
