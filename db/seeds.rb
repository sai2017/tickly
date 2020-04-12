100.times do |n|
  # email = Faker::Internet.email
  # name = Faker::Name.name
  # password = "123456"
  # User.create!(
  #   name: name,
  #   email: email,
  #   password: password,
  #   password_confirmation: password,
  # )

  id = n + 1
  # MailNotificationSetting.create!(
  #   message_flag: 1,
  #   like_flag: 1,
  #   matching_flag: 1,
  #   user_id: aaa
  # )

  LikePoint.create!(
    balance: 10,
    user_id: id
  )
end