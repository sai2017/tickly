class FollowingMailer < ApplicationMailer
  default from: '"Tickly" <info@tickly.jp>'

  def following_to_user(user, follower_user)
    @user_name = user.person.profile.name
    @follower_user_name = follower_user.person.profile.name
    mail(
      subject: "【Tickly】新しい「キョウカン」が届きました！",
      to: user.email
    )
  end
end
