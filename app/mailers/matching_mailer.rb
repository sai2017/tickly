class MatchingMailer < ApplicationMailer
  default from: "support@cordis-dev.com"

  def matching_to_user(user, pair_user)
    # @user = user 
    @user_name = user.person.profile.name
    @pair_user_name = pair_user.person.profile.name
    mail(
      subject: "おめでとうございます！#{@pair_user_name}さんとのマッチングが成立しました！｜cordis",
      to: user.email
    )
  end
end
