class FollowingMailer < ApplicationMailer
  default from: "support@cordis-dev.com"

  def following_to_user(user, follower_user)
    @user = user
    @follower_user = follower_user
    mail(
      subject: "新しい「いいね!」が届きました！｜cordis",
      to: @user.email
    )
  end
end
