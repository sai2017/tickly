class MatchingMailer < ApplicationMailer
  default from: '"Tickly" <info@tickly.jp>'

  def matching_to_user(user, pair_user)
    # @user = user 
    @user_name = user.person.profile.name
    @pair_user_name = pair_user.person.profile.name
    mail(
      subject: "【Baree】おめでとうございます！#{@pair_user_name}さんとのマッチングが成立しました！",
      to: user.email
    )
  end
end
