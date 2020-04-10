class MatchingMailer < ApplicationMailer
  default from: "support@cordis-dev.com"

  def matching_to_user(user, pair_user)
    @user = user
    @pair_user = pair_user
    mail(
      subject: "おめでとうございます！#{@pair_user.name}さんとのマッチングが成立しました！｜cordis",
      to: @user.email
    )
  end
end
