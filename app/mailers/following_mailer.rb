class FollowingMailer < ApplicationMailer
  default from: '"Baree" <info@baree.jp>'

  def following_to_user(user, follower_user)
    @user_name = user.person.profile.name
    @follower_user_name = follower_user.person.profile.name
    mail(
      subject: "新しい「いいね!」が届きました！｜baree",
      to: user.email
    )
  end
end
